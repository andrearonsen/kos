use std::fs::File;
use std::io::{prelude::*, BufReader};

fn main() {
    // let args: Vec<String> = env::args().collect();
    // if args.len() != 1 {
    //     return
    // }
    // let file_path = &args[1];

    let src_path = "/Users/andre/src/kos/dict/nsf2022.txt";
    let dest_path = "/Users/andre/src/kos/kosapp";

    // 4 letter input -> 3-4 letters words
    create_sub_dict(src_path, dest_path, 3, 4);

    // 5 letter input -> 3-5 letters words
    create_sub_dict(src_path, dest_path, 3, 5);

    // 6 letter input -> 3-6 letters words
    create_sub_dict(src_path, dest_path, 3, 6);
}

fn create_sub_dict(src_path: &str, dest_path: &str, min_word_length: usize, max_word_length: usize) {
    let dict = read_dict(src_path, min_word_length, min_word_length);
    // let dict_path = dest_path.to_owned() + "/dict34.txt";
    let dict_path = format!("{}/dict{}{}.txt", dest_path, min_word_length, max_word_length);
    write_dict(&dict_path, dict);
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
    }).map(|res| res.expect("Need word")).collect()
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