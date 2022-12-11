pub mod input;

// // PART 1
// a pair structure for storing the value of our hand & their hand
#[derive(Debug)]
#[allow(dead_code)]
struct Pair {
    our: u8,
    their: u8
}

// create a vector of pairs, containing the values of each round
fn get_matchs() -> Vec<Pair> {
    // split the data by lines, for each match
    input::DATA.split("\n")
    
    // iterate threw each match
    .map(|x|

    // turn each match into pairs with corresponding values
    Pair{ our: match x.split(" ").collect::<Vec<&str>>()[1] {
        "X" => 1,
        "Y" => 2,
        "Z" => 3,
        _ => unreachable!()
    },
    their: match x.split(" ").collect::<Vec<&str>>()[0] {
        "A" => 1,
        "B" => 2,
        "C" => 3,
        _ => unreachable!()
    }})
    .collect::<Vec<Pair>>()
}

// get the result of each match and sums our score
fn total_score(matches: &Vec<Pair>) -> u128 {
    // iterate throw every match
    matches.into_iter()

    // calculate the score of each match
    .map(|x| match x {
        Pair { our: 1, their: 1} => 4,
        Pair { our: 1, their: 2} => 1,
        Pair { our: 1, their: 3} => 7,
        Pair { our: 2, their: 1} => 8,
        Pair { our: 2, their: 2} => 5,
        Pair { our: 2, their: 3} => 2,
        Pair { our: 3, their: 1} => 3,
        Pair { our: 3, their: 2} => 9,
        Pair { our: 3, their: 3} => 6,
        _ => unreachable!()
    })

    // sum it up
    .sum()
}

// // PART 2
// basically the same as total_score, but {X, Y, Z} are how the round is supposed to end
fn score_by_end(matches: &Vec<Pair>) -> u128 {
    // iterate throw every match
    matches.into_iter()

    // calculate the score of each match
    .map(|x| match x {
        Pair { our: 1, their: 1} => 3,
        Pair { our: 1, their: 2} => 1,
        Pair { our: 1, their: 3} => 2,
        Pair { our: 2, their: 1} => 4,
        Pair { our: 2, their: 2} => 5,
        Pair { our: 2, their: 3} => 6,
        Pair { our: 3, their: 1} => 8,
        Pair { our: 3, their: 2} => 9,
        Pair { our: 3, their: 3} => 7,
        _ => unreachable!()
    })

    // sum it up
    .sum()
}

fn main() {
    let matches = get_matchs();

    println!("Matches: {:#?}", matches);

    println!("Our total score durning all the matches based on their item and our item = {:#?}", total_score(&matches));
    println!("Our total score durning all the matches based on their item and our end result = {:#?}", score_by_end(&matches));
}
