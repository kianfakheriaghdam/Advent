(* (* PART 1 *) *)

(* checks if a pair contain each-other's work *)
let compare_work first second =
  (* split each works range by hyphons *)
  let first_work = String.split_on_char '-' first in
  let second_work = String.split_on_char '-' second in

  (* convert the works to integers *)
  let first_work_1 = int_of_string (List.nth first_work 0) in
  let first_work_2 = int_of_string (List.nth first_work 1) in
  let second_work_1 = int_of_string (List.nth second_work 0) in
  let second_work_2 = int_of_string (List.nth second_work 1) in

  (* compare the two, return one if they do contain, other-wise return zero *)
  if first_work_1 <= second_work_1 && first_work_2 >= second_work_2 then 1
  else if second_work_1 <= first_work_1 && second_work_2 >= first_work_2 then 1
  else 0

(* get's how many pairs' works fully contain each-other *)
let count_contained =
  (* get each pair by a new line *)
  let pairs = String.split_on_char '\n' data in
  
  (* iterate throw each elf in a pair & sum it up *)
  List.fold_left (+) 0 (List.map (fun i ->
  
  (* split each pair's elves by a seprater *)
  let elves = String.split_on_char ',' i in

  (* check if their works contain each-other *)
  compare_work (List.nth elves 0) (List.nth elves 1)
  ) pairs)

(* (* PART 2 *) *)

(* creating a range of numbers - n..m *)
let (--) n m = 
  (* create a temporary helper function *)
  let rec aux i acc =
    (* iterate till we reach n, then return the accumulator *)
    if i < n then acc

    (* iterate & add the number to accumulator, also decrement *)
    else aux (i - 1) (i :: acc) in
  
  aux m []

(* check if even one of a list items is in another one *)
let rec compare_list first second =
  (* iterate threw the first list *)
  match first with

  (* if current item is a member of the second list, return true, other-wise check the rest *)
  | x :: xs -> if List.mem x second then 1 else compare_list xs second
  
  (* if there were no equal items, return false *)
  | _ -> 0

(* get's how many pairs' works over-lap each-other *)
let count_overlapped =
  (* get each pair by a new line *)
  let pairs = String.split_on_char '\n' data in
  
  (* iterate throw each elf in a pair & sum it up *)
  List.fold_left (+) 0 (List.map (fun i ->
  
  (* split each pair's elves by a seprater *)
  let elves = String.split_on_char ',' i in

  (* split each works range by hyphons *)
  let first_work = String.split_on_char '-' (List.nth elves 0) in
  let second_work = String.split_on_char '-' (List.nth elves 1) in

  (* convert the works to integers *)
  let first_work_1 = int_of_string (List.nth first_work 0) in
  let first_work_2 = int_of_string (List.nth first_work 1) in
  let second_work_1 = int_of_string (List.nth second_work 0) in
  let second_work_2 = int_of_string (List.nth second_work 1) in

  (* check if works over-lap *)
  compare_list (first_work_1--first_work_2) (second_work_1--second_work_2)
  ) pairs)

let main =
  Printf.printf "Assignments = %s\n" data;

  Printf.printf "Count of pairs that fully contain each-other = %d\n" count_contained;
  Printf.printf "Count of pairs that over-lap each-other = %d\n" count_overlapped
