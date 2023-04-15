use std::fs::File;
use std::io::{prelude::*, BufReader};

fn main() {
    // let args: Vec<String> = env::args().collect();
    // if args.len() != 1 {
    //     return
    // }
    // let file_path = &args[1];

    let file_path = "/Users/andre/src/kos/dict/nsf2022.txt";
    let dict = read_dict(file_path, 3, 5);
    for word in dict {
        println!("{}", word);
    }
}

fn read_dict(dict_file_path: &str, min_word_length: usize, max_word_length: usize) -> Vec<String>  {
    let file = File::open(dict_file_path).expect("Couldnt open file");
    let reader = BufReader::new(file);

    reader.lines().filter(|res| match res {
        Ok(word) =>
            {
                let nr_chars = word.chars().count();
                nr_chars >= min_word_length && nr_chars <= max_word_length
            }
        Err(_) => panic!(),
    }).map(|res| res.expect("Need word"))
    .collect()
}