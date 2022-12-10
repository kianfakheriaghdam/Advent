pub mod input;

// // PART 1
// creates matrix of elf calories
fn get_elves() -> Vec<Vec<u32>> {
    // seprate elf inventories
    input::DATA.split("\n\n")
    
    // seprate elf inventories' calories
    .map(|i| i.split("\n")

    // turn calories into numbers
    .map(|j| j.parse::<u32>().unwrap())
    .collect::<Vec<u32>>())

    .collect::<Vec<Vec<u32>>>()
}

// get the elf with most calories
fn max_calories(elves: &Vec<Vec<u32>>) -> u32 {
    // iterate throw elf inventories
    elves.into_iter()

    // iterate throw elf inventories' elements
    .map(|i| i.into_iter()

    // sum all of elve's calories
    .sum::<u32>())

    // get the elf with most calories
    .into_iter().max().unwrap()
}

// // PART 2
// get the sum of the top three elves with most calories
fn top_calories(elves: Vec<Vec<u32>>) -> u32 {
    // iterate throw elf inventories
    let mut total_calores = elves.into_iter()
    
    // iterate throw elf inventories' elements
    .map(|i| i.into_iter()

    // sum all of elve's calories
    .sum::<u32>())
    .collect::<Vec<u32>>();

    // sort their inventories
    total_calores.sort();

    // sum the top three elf calories
    total_calores[total_calores.len()-1] +
    total_calores[total_calores.len()-2] +
    total_calores[total_calores.len()-3]
}

fn main() {
    let elves = get_elves();

    println!("Elves' Inventories: {:#?}", elves);

    println!("The sum of calories of the elf with most calories = {}", max_calories(&elves));
    println!("The sum of calories of the top three elves with most calories = {}", top_calories(elves));
}
