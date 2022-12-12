(* (* PART 1 *) *)

(* finds the common item between two lists *)
let rec common_member first second =
  (* iterate threw first list *)
  match first with

  (* just give the first item, if the first list is empty *)
  | [] -> List.nth second 0

  (* check if that element is in the second list, other-wise pass *)
  | x :: xs -> if List.mem x second then x else common_member xs second

(* finds the common item between two compartments *)
let common_item first_compartment second_compartment =
  (* seprate each compartment items *)
  let first_compartment_items = List.init (String.length first_compartment) (String.get first_compartment) in
  
  let second_compartment_items = List.init (String.length second_compartment) (String.get second_compartment) in
  
  (* return the common item *)
  common_member first_compartment_items second_compartment_items

(* searches the ruck-sacks for equivalent items, prioritizes them & sums them up *)
let equivalent_sum =
  (* split the ruck-sacks by new-line *)
  let ruck_sacks = String.split_on_char '\n' data in
  
  (* iterate threw ruck-sacks items & sum it *)
  List.fold_left (+) 0 (List.map (fun i -> 
  
  (* get the first compartment *)
  let first_compartment = String.sub i 0 ((String.length i) / 2) in

  (* get the second compartment *)
  let second_compartment = String.sub i ((String.length i) / 2) ((String.length i) / 2) in
  
  (* get the common item between compartments & assign it into a priority *)
  priority (common_item first_compartment second_compartment)
  ) ruck_sacks)

(* (* PART 2 *) *)
(* turns a list into a matrix of lists of three *)
let rec re_shape = function
| x :: xs :: xz :: xt -> [x; xs; xz] :: re_shape xt
| _ -> []

(* gets each group badge & prioritizes the, *)
let rec get_badge first second last =
  (* iterate threw first list *)
  match first with
  
  (* just give the first item, if the first list is empty *)
  | [] -> List.nth second 0
  
  (* check if that element is in the second list & last list, other-wise pass *)
  | x :: xs -> if (List.mem x second) && (List.mem x last) then x else get_badge xs second last

(* gets every group's badge, prioritizes them & sums them up *)
let badge_sum =
  (* split the ruck-sacks by new-line *)
  let ruck_sacks = String.split_on_char '\n' data in
  
  (* group the elves by ruck-sacks *)
  let groups = re_shape ruck_sacks in
  
  (* iterate threw each group & sums them up *)
  List.fold_left (+) 0 (List.map (fun i -> 
  
  (* iterate threw each group member *)
  let group = List.map (fun j ->
  
  (* get their items *)
  List.init (String.length j) (String.get j)
  ) i in
  
  (* get the badge of each member & assign them to a priority *)
  priority (get_badge (List.nth group 0) (List.nth group 1) (List.nth group 2))
  ) groups)

let () =
  Printf.printf "Ruck-Sacks: %s\n" data;
  
  Printf.printf "Sum of common prioritized items between ruck-sacks = %d\n" equivalent_sum;
  Printf.printf "Sum of each group badge = %d\n" badge_sum;
