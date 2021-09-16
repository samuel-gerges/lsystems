(*open Systems;*)

type command =
  | Line of int
  | Move of int
  | Turn of int
  | Store
  | Restore

type position = {
    x: float;      (** position x *)
    y: float;      (** position y *)
    a: int;        (** angle of the direction *)
  }

(** Put here any type and function implementations concerning turtle *)

let stored_pos = Stack.create();;
              
let radian a =
  (a*.(4.*.atan(1.)))/.180.0
;;

let change_orientation (angle : int) (current_pos : position) =
  {x = current_pos.x; y = current_pos.y; a = current_pos.a + angle}
;;

let store (pos : position) =
  Stack.push pos stored_pos;
  pos
;;

let restore (pos : position) =
  if(not(Stack.is_empty stored_pos)) then Stack.pop stored_pos
  else pos
;;

let line dist pos dim iter =
  let foi = float_of_int in
  let iof = int_of_float in
  let new_x = pos.x +. ((foi dist)*.(1./.(dim ** foi (iter))))*.cos(radian (foi pos.a)) in
  let new_y = pos.y -. ((foi dist)*.(1./.(dim ** foi (iter))))*.sin(radian (foi pos.a)) in
  Graphics.lineto (iof new_x) (iof new_y);
  {x = new_x; y = new_y; a = pos.a}
;;

let move dist pos dim iter =
  let foi = float_of_int in
  let iof = int_of_float in
  let new_x = pos.x +. ((foi dist)*.(1./.(dim ** foi (iter))))*.cos(radian (foi pos.a)) in
  let new_y = pos.y -. ((foi dist)*.(1./.(dim ** foi (iter))))*.sin(radian (foi pos.a)) in
  Graphics.moveto (iof new_x) (iof new_y);
  {x = new_x; y = new_y; a = pos.a}
;;

let draw (pos : position) (cmd : command list) (dim : float) (n : int) =
  match List.hd cmd with
    Line b -> line b pos dim n
  | Move b -> move b pos dim n
  | Turn b -> change_orientation b pos
  | Store -> store pos
  | Restore -> restore pos
;;
