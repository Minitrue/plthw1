{
  type token = EOF | Word of string 
  module StringMap = Map.Make(String)
}

rule token = parse
| eof { EOF }
| ['a'-'z' 'A'-'Z']+ as word {Word(word)}
| _ { token lexbuf }
{
  let lexbuf = Lexing.from_channel stdin in
  let wordlist = 
    let rec next l = 
      match token lexbuf with
        EOF -> l
      | Word(s) -> next (s :: l)
    in next []
  in
  let rec trackwords wl wc = match wl with
    [] -> wc
  | hd :: tl -> let newwc  = trackwords tl wc in
                  if StringMap.mem hd newwc then
                    let count = StringMap.find hd newwc in
                      StringMap.add hd (count+1) newwc
                  else
                      StringMap.add hd 1 newwc
  in
  let wordcounts = StringMap.empty in
    let wordmap = trackwords wordlist wordcounts in 
      let wordmap_list = StringMap.fold (fun k v l -> (v,k) :: l) wordmap [] in
        let sorted_counts = 
          List.sort (fun (c1,_) (c2,_) ->
                    Pervasives.compare c2 c1) wordmap_list in
            List.iter print_endline (List.map (fun tup -> ((string_of_int (fst tup)) ^ " " ^ snd tup)) sorted_counts)
        (*let print_test i = print_string (fst i) in
          List.iter print_test wordmap_list*)
      (*let print_test k v = print_string(k ^ " " ^ v) in
        StringMap.iter print_test track_result*)
  (*List.iter countwords wordlist*)
    
    
  (*List.iter print_endline wordlist*)
}
