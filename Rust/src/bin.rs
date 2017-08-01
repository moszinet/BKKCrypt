use std::env;
use std::process;
extern crate bkkcrypt_lib;

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 2 {
        println!(
            "Please provide a single parameter to encrypt with the famous BKKCrypt algorithm."
        );
        process::exit(1);
    }

    let ref item = &args[1];

    let result = bkkcrypt_lib::encrypt(item);

    println!("{}", result);
}