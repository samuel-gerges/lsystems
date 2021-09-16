(* Examples tirés du livre "The Algorithmic Beauty of Plants".
   Un exemple consiste en un axiome, un système de réécriture,
   et une interprétation. Pour plus d'exemples, voir les fichiers
   dans le répertoire examples/
*)

(* Pour l'exemple ci-dessous, ces trois symboles suffisent.
   A vous de voir ce que vous voudrez faire de ce type symbol ensuite.
*)

type symbol = A|B|C|P|M|S|R

(* snow flake  - Figure 3 du sujet *)

val snow : symbol Systems.system

val plant : symbol Systems.system

val dragon : symbol Systems.system

val snow_props : symbol Systems.system_properties

val br1_props : symbol Systems.system_properties

val br2_props : symbol Systems.system_properties

val br3_props : symbol Systems.system_properties

val dragon_props : symbol Systems.system_properties

val htree_props : symbol Systems.system_properties

val koch_props : symbol Systems.system_properties

val koch1_props : symbol Systems.system_properties

val koch2_props : symbol Systems.system_properties
  
val sierpinski_props : symbol Systems.system_properties
  
val fractal_plant_props : symbol Systems.system_properties
                    
