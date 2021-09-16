
open Lsystems (* Librairie regroupant le reste du code. Cf. fichier dune *)
open Systems (* Par exemple *)
open Turtle
open Examples

(** Gestion des arguments de la ligne de commande.
    Nous suggérons l'utilisation du module Arg
    http://caml.inria.fr/pub/docs/manual-ocaml/libref/Arg.html
*)

let usage = (* Entete du message d'aide pour --help *)
  "Interpretation de L-systemes et dessins fractals"

let action_what () = Printf.printf "%s\n" usage; exit 0

let cmdline_options = [
("--what" , Arg.Unit action_what, "description");
]

let extra_arg_action = fun s -> failwith ("Argument inconnu :"^s)
       
let interaction () =
  Graphics.open_graph " 2000x1500";
  
  let ls_tab = [|snow_props; br1_props; br2_props; br3_props; dragon_props; htree_props; koch_props; koch1_props; koch2_props; sierpinski_props; fractal_plant_props;|] in (* tableau de L-systèmes présents dans `examples.ml` *)
  
  ignore(cast (ls_tab.(0)) (0)); Graphics.set_color Graphics.black;
  Graphics.moveto 10 850;
  Graphics.draw_string ls_tab.(0).name;
  Graphics.moveto 10 830;
  Graphics.draw_string "depth : ";
  Graphics.draw_string (string_of_int 0 );
  
  let n = ref 0 in (* entier correspopnd aux itérations d'un L-système *)
  let i = ref 0 in (* entier correspopnd aux indexs du tableau des L-systèmes *)


  while true do
    let draw_infos = Graphics.set_color Graphics.black;
                     Graphics.moveto 10 850;
                     Graphics.draw_string ls_tab.(!i).name;
                     Graphics.moveto 10 830;
                     Graphics.draw_string "depth : ";
                     Graphics.draw_string (string_of_int !n)
    in
    
    let event = Graphics.wait_next_event 
                  [Graphics.Key_pressed]
              
    in if(event.Graphics.key = 'a') then (Graphics.clear_graph();
                                          ignore(cast (ls_tab.(!i)) ((!n)+1));
                                          n := !n+1;
                                          draw_infos)
       
       else if(event.Graphics.key = 'z') then begin
           if(!n > 0) then (Graphics.clear_graph();
                            ignore(cast (ls_tab.(!i)) ((!n)-1));
                            n := !n-1;
                            draw_infos)
         end
       
       else if(event.Graphics.key = 'q') then begin
           if(!i <> (Array.length ls_tab)-1) then (Graphics.clear_graph();
                                                   n := 0;
                                                   i := !i + 1;
                                                   draw_infos;
                                                   ignore(cast (ls_tab.(!i)) (!n)));
         end

       else if(event.Graphics.key = 's') then begin
           if(!i <> 0) then (Graphics.clear_graph();
                             n := 0;
                             i := !i - 1;
                             draw_infos;
                             ignore(cast (ls_tab.(!i)) (!n)));
         end
       
       else if(event.Graphics.key = 'e') then Graphics.close_graph()
  done
;;

(* Seule chose que l'on fait dans le `main` est d'appeler `interaction()`  *)

let main =
  Arg.parse cmdline_options extra_arg_action usage;

  interaction()

(** On ne lance ce main que dans le cas d'un programme autonome
    (c'est-à-dire que l'on est pas dans un "toplevel" ocaml interactif).
    Sinon c'est au programmeur de lancer ce qu'il veut *)

let _ = if not !Sys.interactive then main
