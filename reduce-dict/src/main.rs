#![warn(clippy::all, clippy::pedantic)]

use std::collections::HashMap;
use std::fs::File;
use std::io::{prelude::*, BufReader};
use regex::Regex;

fn main() {
    let src_path = "/Users/andre/src/kos/dict/nsf2022.txt";
    let master_list = read_master_wordlist(src_path, 2, 6);

    let dest_path = "/Users/andre/src/kos/dict/";

    let src_freq_path = "/Users/andre/src/kos/dict/ordliste-frekvens.txt";
    create_sub_dict_humfak_ordlist(src_freq_path, dest_path, 2, 200, &master_list);
    create_sub_dict_humfak_ordlist(src_freq_path, dest_path, 3, 1500, &master_list);
    create_sub_dict_humfak_ordlist(src_freq_path, dest_path, 4, 2000, &master_list);
    create_sub_dict_humfak_ordlist(src_freq_path, dest_path, 5, 2000, &master_list);
    create_sub_dict_humfak_ordlist(src_freq_path, dest_path, 6, 2000, &master_list);


    // let args: Vec<String> = env::args().collect();
    // if args.len() != 1 {
    //     return
    // }
    // let file_path = &args[1];

    // let src_path = "/Users/andre/src/kos/dict/nsf2022.txt";
    // // 4 letter input -> 3-4 letters words
    // create_sub_dict(src_path, dest_path, 3, 4);
    //
    // // 5 letter input -> 3-5 letters words
    // create_sub_dict(src_path, dest_path, 3, 5);
    //
    // // 6 letter input -> 3-6 letters words
    // create_sub_dict(src_path, dest_path, 3, 6);

    // 3 letter input -> 3 letters words
    // create_sub_dict(src_path, dest_path, 3, 3, "wl3.txt");

    // 4 letter input -> 4 letters words
    // create_sub_dict(src_path, dest_path, 4, 4, "wl4.txt");

    // 5 letter input -> 5 letters words
    // create_sub_dict(src_path, dest_path, 5, 5, "wl5.txt");

    // 6 letter input -> 6 letters words
    // create_sub_dict(src_path, dest_path, 6, 6, "wl6.txt");
}

fn create_sub_dict_humfak_ordlist(src_path: &str, dest_path: &str, word_length: usize, word_list_size: usize, master_map: &HashMap<String, bool>) {
    let freq_word_lines = read_dict(src_path);

    // lazy_static! {
    //     static ref LINE_REGEX: Regex = Regex::new(r"^\s*(\d+)\s+([A-Za-zÆØÅæøå]+)\s*$").unwrap();
    // }

    let line_regex: Regex = Regex::new(r"^\s*(\d+)\s+([A-Za-zÆØÅæøå]+)\s*$").unwrap();

    // Preprocess http://korpus.uib.no/humfak/nta/ordlist.zip -> ORDLIST.TXT
    // 0. Convert to utf-8: iconv -f iso-8859-1 -t utf8 ORDLIST.TXT > ordliste-utf8.txt
    // 1. Map to tuple (frequency, word)
    // 2. Filter by frequency > x
    // 3. Map to word
    // 4. Filter on regex [A-Za-zÆØÅæøå]+
    let mut freq_words: Vec<(i32, String)> = Vec::with_capacity(freq_word_lines.len());
    freq_word_lines.into_iter()
        .filter(|line| {
            line_regex.is_match(line)
        })
        .map(|line| {
            let caps = line_regex.captures(&line).unwrap();
            let first: &str = caps.get(1).map_or("", |m| m.as_str());
            let second: &str = caps.get(2).map_or("", |m| m.as_str());
            let frequency: i32 = first.parse::<i32>().unwrap();
            let word: String = second.to_uppercase();
            (frequency, word)
        })
        .filter(|(_, w)| {
            let len = w.chars().count();
            len == word_length
        })
        .filter(|(_, w)| {
            master_map.contains_key(w)
        })
        .for_each(|fw| {
        freq_words.push(fw);
    });

    freq_words.sort_by_key(|(f,_)| {
        -f
    });

    let dict: Vec<String> =
        freq_words.into_iter()
        .take(word_list_size)
        .map(|(_,w)| {
            w
        })
        .collect();

    println!("Total dict size {}", dict.len());
    let dict_path = format!("{}/wlf{}.txt", dest_path, word_length);
    write_dict(&dict_path, dict);
}

// fn create_sub_dict(src_path: &str, dest_path: &str, min_word_length: usize, max_word_length: usize, filename: &str) {
//     let mut dict = read_dict(src_path);
//     dict.sort_by_key(|w| w.chars().count());
//     println!("Total dict size {}", dict.len());
//
//     let dict = sub_dict(dict, min_word_length, max_word_length);
//     println!("Writing {} words into sub-dict", dict.len());
//     let dict_path = format!("{}/{}", dest_path, filename);
//     write_dict(&dict_path, dict);
// }

fn read_master_wordlist(src_path: &str, min_word_length: usize, max_word_length: usize) -> HashMap<String, bool> {
    let mut dict = read_dict(src_path);
    dict.sort_by_key(|w| w.chars().count());
    println!("Total dict size {}", dict.len());

    let d = sub_dict(dict, min_word_length, max_word_length);
    let map_names_by_id: HashMap<String, bool> = d.iter().map(|w| (w.clone(), true)).collect();

    map_names_by_id
}

fn sub_dict(dict: Vec<String>, min_word_length: usize, max_word_length: usize) -> Vec<String> {
    dict.into_iter()
        .filter(|w| {
            let len = w.chars().count();
            len >= min_word_length && len <= max_word_length
        })
        .map(|w| {
            w.to_uppercase()
        })
        .collect()
}

fn read_dict(dict_file_path: &str) -> Vec<String>  {
    let file = File::open(dict_file_path).expect("Couldnt open file");
    let reader = BufReader::new(file);

    reader.lines()
        .filter_map(|r| r.ok())
        .collect()
}

fn write_dict(dict_file_path: &str, dict: Vec<String>) {
    let mut dict_file = match File::create(&dict_file_path) {
        Err(why) => panic!("couldn't create {}: {}", dict_file_path, why),
        Ok(file) => file,
    };
    match dict_file.write_all(dict.join("\n").as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", dict_file_path, why),
        Ok(_) => println!("successfully wrote to {}", dict_file_path),
    }
}