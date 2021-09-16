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
                          
(** Put here any type and function interfaces concerning systems *)
                          
val substitute : 's system -> 's word

val substitute_n : 's system -> int -> 's word

val cast : 's system_properties -> int -> Turtle.position
