let ass x = x + 1;;
(* takes in list of strings *)
let rec oxford = fun l -> match l with
  [] -> ""
| [x] -> x
| [x; y] -> String.concat " and " [x; y]
| [x; y; z] -> String.concat ", and " [(String.concat ", " [x; y]); z]
| hd :: tl -> String.concat ", " [hd; (oxford tl)];;

print_string (oxford []);;
print_newline ();;
print_string (oxford ["A"]);;
print_newline ();;
print_string (oxford ["A"; "B"]);;
print_newline ();;
print_string (oxford ["A"; "B"; "C"]);;
print_newline ();;
print_string (oxford ["A"; "B"; "C"; "D"]);;
print_newline ();;
 
