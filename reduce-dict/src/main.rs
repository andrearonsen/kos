use std::fs::File;
use std::io::{prelude::*, BufReader};

fn main() {
    // let args: Vec<String> = env::args().collect();
    // if args.len() != 1 {
    //     return
    // }
    // let file_path = &args[1];

    let src_path = "/Users/andre/src/kos/dict/nsf2022.txt";
    let dest_path = "/Users/andre/src/kos/dict/";

    // // 4 letter input -> 3-4 letters words
    // create_sub_dict(src_path, dest_path, 3, 4);
    //
    // // 5 letter input -> 3-5 letters words
    // create_sub_dict(src_path, dest_path, 3, 5);
    //
    // // 6 letter input -> 3-6 letters words
    // create_sub_dict(src_path, dest_path, 3, 6);

    // 3 letter input -> 3 letters words
    create_sub_dict(src_path, dest_path, 3, 3);

    // 4 letter input -> 4 letters words
    create_sub_dict(src_path, dest_path, 4, 4);

    // 5 letter input -> 5 letters words
    create_sub_dict(src_path, dest_path, 5, 5);

    // 6 letter input -> 6 letters words
    create_sub_dict(src_path, dest_path, 6, 6);
}

fn create_sub_dict(src_path: &str, dest_path: &str, min_word_length: usize, max_word_length: usize) {
    let mut dict = read_dict(src_path);
    dict.sort_by_key(|w| w.chars().count());
    println!("Total dict size {}", dict.len());

    let dict = sub_dict(dict, min_word_length, max_word_length);
    println!("Writing {} words into sub-dict", dict.len());
    let dict_path = format!("{}/wl{}{}.txt", dest_path, min_word_length, max_word_length);
    write_dict(&dict_path, dict);
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