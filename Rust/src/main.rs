use std::env;
use std::process;

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 2 {
        println!("Please provide a single parameter to encrypt with the famous BKKCrypt algorithm.");
        process::exit(1);
    }

    println!("{}", args[1]);
}
