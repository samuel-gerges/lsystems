open Systems
open Turtle

(* Examples tirés du livre "The Algorithmic Beauty of Plants".
   Un exemple consiste en un axiome, un système de réécriture,
   et une interprétation. Pour plus d'exemples, voir les fichiers
   dans le répertoire examples/
*)

(* Pour l'exemple ci-dessous, ces trois symboles suffisent.
   A vous de voir ce que vous voudrez faire de ce type symbol ensuite.
 *)

type symbol = A|B|C|P|M|S|R

let snow : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  {
    axiom = Seq [a;p;p;a;p;p;a];
    rules =
      (function
       | A -> Seq [a;m;a;p;p;a;m;a]
       | s -> Symb s);
    interp =
      (function
       | A -> [Line 600]
       | P -> [Turn 60]
       | M -> [Turn (-60)]
       | S -> [Turn 0] (* dans ce L-système on est pas censé tomber sur S ni R mais si on ajoute pas ces deux lignes (qui ne font rien), cela crée une erreur à la compilation car tous les cas ne sont pas traités *)
       | R -> [Turn 0]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }

let plant : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [a;s;p;a;r;a;s;m;a;r;a]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 800]
       | P -> [Turn 25]
       | M -> [Turn (-25)]
       | S -> [Store]
       | R -> [Restore]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }
  
let sierpinski : symbol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  let m = Symb M in
  {
    axiom = Seq [a;m;b;m;b];
    rules =
      (function
       | A -> Seq [a;m;b;p;a;p;b;m;a]
       | B -> Seq [b;b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 700]
       | B -> [Line 700]
       | P -> [Turn 120]
       | M -> [Turn (-120)]
       | S -> [Turn 0]
       | R -> [Turn 0]
       | C -> [Turn 0])
  }
  
let fractal_plant : symbol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [b;p;s;s;a;r;m;a;r;m;b;s;m;b;a;r;p;a]
       | B -> Seq [b;b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Turn 0]
       | B -> [Line 300]
       | P -> [Turn (-25)]
       | M -> [Turn 25]
       | S -> [Store]
       | R -> [Restore]
       | C -> [Turn 0])
  }
  


let cantor : symbol system =
  let a = Symb A in
  let b = Symb B in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [a;b;a]
       | B -> Seq [b;b;b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 500]
       | B -> [Move 500]
       | P -> [Turn 0]
       | M -> [Turn 0]
       | S -> [Turn 0]
       | R -> [Turn 0]
       | C -> [Turn 0])
  }

let dragon : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [a;m;p;m]
       | P -> Seq [s;a;s;p]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 500]
       | P -> [Line 500]
       | M -> [Turn 90]
       | S -> [Turn (-90)]
       | R -> [Turn 0]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }

  
let br1 : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [a;s;p;a;r;a;s;m;a;r;a]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 500]
       | P -> [Turn 25]
       | M -> [Turn (-25)]
       | S -> [Store]
       | R -> [Restore]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }


let br2 : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [a;s;p;a;r;a;s;m;a;r;s;a;r]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 400]
       | P -> [Turn 20]
       | M -> [Turn (-20)]
       | S -> [Store]
       | R -> [Restore]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }

let br3 : symbol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [b;s;p;a;r;s;m;a;r;b;a]
       | B -> Seq [b;b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 400]
       | B -> [Line 400]
       | P -> [Turn 25]
       | M -> [Turn (-25)]
       | S -> [Store]
       | R -> [Restore]
       | C -> [Turn 0])
  }


let htree : symbol system =
  let a = Symb A in
  let b = Symb B in
  let c = Symb C in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Symb A;
    rules =
      (function
       | A -> Seq [b;s;p;a;r;m;a]
       | B -> Seq [c;c]
       | C -> Seq [b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 10]
       | B -> [Line 14]
       | C -> [Line 10]
       | P -> [Turn 90]
       | M -> [Turn (-90)]
       | S -> [Store]
       | R -> [Restore])
  }




let koch : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Seq [a;p;a;p;a;p;a];
    rules =
      (function
       | A -> Seq [a;m;a;a;p;a;a;p;a;p;a;m;a;m;a;a;p;a;p;a;m;a;m;a;a;m;a;a;p;a]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 200]
       | P -> [Turn 90]
       | M -> [Turn (-90)]
       | S -> [Turn 0]
       | R -> [Turn 0]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }
    
    
let koch1 : symbol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Seq [a;p;a;p;a;p;a];
    rules =
      (function
       | A -> Seq [a;p;b;m;a;a;p;a;p;a;a;p;a;b;p;a;a;m;b;p;a;a;m;a;m;a;a;m;a;b;m;a;a;a]
       | B -> Seq [b;b;b;b;b;b]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 200]
       | B -> [Move 200]
       | P -> [Turn 90]
       | M -> [Turn (-90)]
       | S -> [Turn 0]
       | R -> [Turn 0]
       | C -> [Turn 0])
  }



let koch2 : symbol system =
  let a = Symb A in
  let p = Symb P in
  let m = Symb M in
  let s = Branch (Symb S) in
  let r = Branch (Symb R) in
  {
    axiom = Seq [a;p;a;p;a;p;a];
    rules =
      (function
       | A -> Seq [a;a;p;a;p;a;p;a;p;a;p;a;m;a]
       | x -> Symb x);
    interp =
      (function
       | A -> [Line 400]
       | P -> [Turn 90]
       | M -> [Turn (-90)]
       | S -> [Turn 0]
       | R -> [Turn 0]
       | B -> [Turn 0]
       | C -> [Turn 0])
  }



  

let snow_props : symbol system_properties =
  { ls = snow; fp = {x = 500.0; y = 600.0; a = 0}; dim = 3.; name = "snow "}

let br1_props : symbol system_properties =
  { ls = plant; fp = {x = 1000.0; y = 50.0; a = (-90)}; dim = 3.; name = "br1 "}

let br2_props : symbol system_properties =
  { ls = br2; fp = {x = 1000.0; y = 50.0; a = (-90)}; dim = 2.; name = "br2 "}

let br3_props : symbol system_properties =
  { ls = br3; fp = {x = 800.0; y = 50.0; a = (-90)}; dim = 2.; name = "br3 "}

let dragon_props : symbol system_properties =
  { ls = dragon; fp = {x = 1000.0; y = 500.0; a = 0}; dim = 1.5; name = "dragon "}

let htree_props : symbol system_properties =
  { ls = htree; fp = {x = 1000.0; y = 300.0; a = (-90)}; dim = 1.; name = "htree "}

let koch_props : symbol system_properties =
  { ls = koch; fp = {x = 1000.0; y = 700.0; a = 0}; dim = 5.; name = "koch "}

let koch1_props : symbol system_properties =
  { ls = koch1; fp = {x = 800.0; y = 700.0; a = 0}; dim = 5.; name = "koch1 "}

let koch2_props : symbol system_properties =
  { ls = koch2; fp = {x = 1000.0; y = 700.0; a = 0}; dim = 3.25; name = "koch2 "}

let sierpinski_props : symbol system_properties =
  { ls = sierpinski; fp = {x = 600.0; y = 200.0; a = 0}; dim = 2.; name = "sierpinski "}
  
let fractal_plant_props : symbol system_properties =
  { ls = fractal_plant; fp = {x = 1000.0; y = 50.0; a = (-90)}; dim = 2.; name = "fractal_plant "}
