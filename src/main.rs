use avent::get_solution;
use std::error::Error;
use structopt::StructOpt;

#[derive(StructOpt)]
struct Cli {
    #[structopt(help = "AOC day", default_value = "1")]
    day: u8,

    #[structopt(short, long, help = "Uses example file provided by AOC")]
    example: bool,

    #[structopt(short, long, help = "Gets all solutions for all AOC days")]
    all: bool,
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Cli::from_args();
    let main_file = if args.example { "example" } else { "input" };

    if args.all {
        (1..=9).for_each(|d| get_solution(main_file, d));
    } else {
        get_solution(main_file, args.day);
    }

    Ok(())
}
