(** Words, rewrite systems, and rewriting *)
   
type 's word =
  | Symb of 's
  | Seq of 's word list
  | Branch of 's word

type 's rewrite_rules = 's -> 's word

type 's system = {
    axiom : 's word;
    rules : 's rewrite_rules;
    interp : 's -> Turtle.command list }

type 's system_properties = {
    ls : 's system;
    fp : Turtle.position; (* la position de départ *)
    dim : float; (* représente la diminution de la longueur des traits quand on passe un niveau d'itération *)
    name : string; (* le nom du L-système *)
  }    
    
(** Put here any type and function implementations concerning systems *)

let colors = [|Graphics.red; Graphics.black; Graphics.green; Graphics.blue; Graphics.yellow; Graphics.cyan; Graphics.magenta|]
;;

let rec substitute (ls : 's system) =
  match ls.axiom with
    Symb s -> ls.rules s
  | Seq l -> let rec loop ls_2 list =
               match list with
                 [] -> []
               | h :: tail -> substitute {axiom = h; rules = ls_2.rules; interp = ls_2.interp } :: loop ls_2 tail
             in Seq (loop ls l)
  | Branch w -> Branch (substitute {axiom = w; rules = ls.rules; interp = ls.interp})
;;

let rec substitute_n (ls: 's system) (n : int) =
  if(n = 0) then ls.axiom
  else substitute_n ({axiom = (substitute ls); rules = ls.rules; interp = ls.interp}) (n-1)
;;

let cast (ls_props : 's system_properties) (n : int) =
  if(n<0) then failwith "Rentrez un entier naturel dans cast."
    else let w = substitute_n (ls_props.ls) n in
         let rec loop (word : 's word) (pos : Turtle.position) =
           match word with
             Symb s -> let index = Random.int 6 in Graphics.set_color colors.(index); Turtle.draw (pos) (ls_props.ls.interp s) (ls_props.dim) n
           | Seq l -> begin match l with
                        [] -> pos
                      | h :: tail -> loop (Seq tail) (loop h pos)
                      end
           | Branch w_2 -> loop w_2 pos
         in Graphics.moveto (int_of_float ls_props.fp.x) (int_of_float ls_props.fp.y);
            loop w (ls_props.fp)
;;



    
