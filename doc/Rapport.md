RAPPORT DU PROJET
=================

Identifiants
------------
* GERGES Samuel; @gerges; 71804327
* JAMI Adam; @jami; 71803537

_Ce fichier permet d'avoir une vision globale sur le projet et sur comment nous l'avons abordé, et liste l'ensemble des méthodes implémentées avec pour chacune des explications._

Fonctionnalités
---------------

Le sujet minimal pour ce projet imposait de pouvoir visualiser les figures produites par des interprétations arbitraires d'itérations de L-systèmes arbitraires. Nous sommes arrivés à un résultat concluant, respectant bien cette spécification. En quelques mots, à l'exécution de notre programme (avec la commande `./run`), une image graphique s'ouvre et propose une première figure correspondant à la première itération d'un L-système. Des intéractions avec le clavier sont possibles. En particulier, la touche `a` de votre clavier vous permettra d'augmenter les itérations du L-système en question, `z` de les diminuer. La touche `q` vous permettra de changer de L-système, `s` de revenir au L-système précédent. `e` vous permettra de fermer la fenêtre graphique et par conséquent de quitter le programme. Pour chaque L-système, des informations (nom et profondeur d'itération) sont affichées en haut à gauche de la fenêtre.

Méthodes implémentées
---------------------

_Afin d'éviter un code surchargé de commentaires, nous avons choisi d'expliquer le fonctionnement de toutes les fonctions implémentées dans cette section et de faire seulement de légers commentaires directement dans le code._

* `turtle.ml` contenant :

   * Une variable globale `stored_pos` de type `position t` du module `Stack` permettant de stocker la position que l'on veut sauvegarder. En effet, nous n'avons pas trouvé d'autre moyen que d'utiliser cette structure mutable pour stocker une position à récupérer plus tard.
 
   * Une fonction `radian : float -> float` prenant en entrée un angle (supposé exprimé en degré(s)) et renvoie sa valeur en radian(s).
 
   * Une fonction `change_orientation : -> int -> position -> position` qui retourne une nouvelle position ayant les mêmes coordonnées que celle passée en argument mais avec un champ `a` auquel on a ajouté la valeur en paramètre.
 
   * Une méthode `store : position -> position` qui sauvegarde la position en paramètre en l'empilant dans `stored_pos` et la retourne.
 
   * Une méthode `restore : position -> position` qui, si `stored_pos` n'est pas vide, dépile son sommet et le retourne. Sinon, elle retourne la position passée en paramètre.
 
   * `line : int -> position -> int -> int -> position` va, en fonction d'une distance entrée en paramètre, dessiner un trait (dans une fenêtre graphique ouverte au préalable) jusqu'au nouveau point de coordonnées qui est calculé selon les règles de calculs suivantes :
   * la nouvelle coordoonée `x2` selon l'ancienne cordoonnée `x`, une distance `dist` et un angle `a` est : `x2 = x + dist * cos(a)` (`a` doit ici être en radians).
   * la nouvelle coordoonée `y2` selon l'ancienne cordoonnée `y`, une distance `dist` et un angle `a` est : `y2 = y - dist * sin(a)` (`a` doit ici être en radians).
 Le facteur de réduction `dim` et l'entier `iter` représentant l'itération du L-système sont utilisés pour permettre à la figure de garder une taille raisonnable et de ne pas dépasser les bornes du graphique. Si le facteur de réduction est 3 et qu'on est à la 2ème itération, les traits que l'on va tracer seront de taille `dist * 1/3^2`.
 La fonction va ensuite retourner cette nouvelle position.
 
   * `move : int -> position -> int -> int -> position` va, en fonction d'une distance entrée en paramètre, se déplacer (dans une fenêtre graphique ouverte au préalable) jusqu'au nouveau point de coordonnées qui est calculé selon les mêmes règles que pour `line`.
 La fonction va ensuite retourner cette nouvelle position.
 
   * Une méthode `draw : position -> command list -> int -> int -> position` qui est juste un `match` sur une commande qui va retourner, selon le type de la commande, la nouvelle position de la tortue graphique à l'aide des fonctions auxilaires implémentées ci-dessus. Certaines de ces fonctions auront alors des effets de bords.

* `systems.ml` contenant :

   * un nouveau type :
```
type 's system_properties = {
    ls : 's system;
    fp : Turtle.position; (* la position de départ *)
    dim : int; (* représente la diminution de la longueur des traits quand on passe un niveau d'itération *)
    name : string; (* le nom du L-système *)
  }
```
   Ce type contient des propriétés d'un L-système donné. En particulier, sa position initiale dans la fenêtre graphique, son facteur de diminution des traits quand on passe à une itération au-dessus et son nom.

   * Une fonction `substitute : 's system -> 's word` qui pour un L-système donné va retourner
 l'axiome de ce dernier, transformé selon les règles de substitutions du L-système.

   * Une fonction `substitute_n : 's system -> int -> 's word` qui pour un entier `n` et un L-   système donnés va appliquer `substitute` `n` fois à l'axiome du L-système en paramètre et ainsi
 retourner cet axiome transformé `n` fois selon les règles de substitutions du L-système.
 
   * Une méthode `cast : 's system_properties -> int -> Turtle.position` qui va dans un premier temps appliquer `substitute_n` sur l'axiome du L-système en paramètre, puis dans une méthode auxiliaire récursive, appliquer `draw` à chaque `Symb` de l'axiome transformé. Cette fonction a pour effet de bord de se placer à un point précis dans une fenêtre déjà ouverte et de dessiner, selon les intérprétations des commandes. Avant chaque appel à `draw` on modifife la couleur courante avec `Graphics.set_color` (en prenant une couleur au hasard d'un tableau de couleurs déclaré au début du fichier) pour obtenir un affichage coloré.
 
* `examples.ml` contenant des définitions d'exemples de L-systèmes :

   * `type symbol = A|B|C|P|M|S|R` : un type définissant les différents symboles dont on va avoir besoin pour définir l'axiome et les règles de substitutions d'un L-système.
 
   * différents exemples de L-systèmes comme `snow`, `br1`, `koch`, `dragon` etc...
 
   * et leurs `'s system_properties` appropriés, avec les bonnes positions de départ et les bons facteurs de réductions.
 
* `main.ml` contenant :

   * `interaction() : unit -> unit` : cette méthode est la méthode principale qui va utiliser `cast` et comme son nom l'indique, créer une interaction avec l'utilisateur. Elle est implémentée en impératif car quand on a un état global à maintenir et qu'on veut pouvoir changer cet état en place, c'est approprié. Cette fonction étant la fonction principale, la description qui suit représente le déroulement du programme en lui-même.
 Dans cette fonction on ouvre une fenêtre graphique au tout début, puis on déclare 3 références : un tableau de `system_propreties` définies au préalable dans le fichier `examples.ml`, un entier `n` définissant une itération d'un L-système (qui va être incrémenté / décrémenté durant l'exécution du programme) et un entier `i` définissant l'index du tableau de `system_propreties`.
 Tout d'abord, on fait un premier appel à `cast` qui va afficher sur la fenêtre graphique la figure correspondant à la première itération du premier L-systèmes du tableau, puis on affiche également le noom de ce L-système puis la profondeur d'itération (qui est à 0 au début).
 Ensuite, dans un `while` infini on attend le prochain événement avec la fonction `wait_next_event` du module `Graphics`. Le seul événement qu'on attend ici est que l'utilisateur appuie sur un boutton de son clavier, et selon le boutton plusieurs actions peuvent s'exécuter :
 `a` -> on dessine le premier L-système du tableau (avec `cast`) à l'itération `n+1` (au début `n` est à 0). Puis on met `n` à jour (`n++`) et on attend le prochain événement.
 `z` -> on revient d'une itération en arrière dans le L-système qu'on a dessiné, toujours avec un appel à `cast`, et on fait `n--`. Si on est à la première itération d'un L-système, `z` ne fera rien (car on ne pas revenir en arrière).
 `q` -> on fait un `clear_graph()`, on met le compteur des itérations à 0 et on augmente de 1 l'index du tableau des L-systèmes. Ainsi on passe à un autre L-système et en appuyant sur `a` ou `z` on peut passer d'itérations en itérations dans ce nouveau L-système.
 `s` -> fait la même chose que `q` mais dans l'autre sens (on revient au L-système précédent).
 `e` -> ferme la fenêtre graphique et termine donc le programme.
 
 À chaque tour de boucle, que l'on passe d'une itération à une autre ou d'un L-système à un autre, on met à jour les informations (nom et profondeur d'itération) puis on les affiche après l'affichage de la figure. (**Remarque :** Nous avons essayé d'agrandir la taille du texte affiché pour les informations, mais apparemment la fonction `Graphics.set_text_size` n'est pas implémentée...).
 
 Compilation et exécution
 ------------------------
 
 Pour compiler le projet, un Makefile est fourni : `make`
 Pour l'éxécuter : `./run`
 
 Nous avons utilisés les bibliothèques externes suivantes :
 
  * `Graphics` : https://ocaml.github.io/graphics/graphics/Graphics/index.html
  
  * `Array` : https://caml.inria.fr/pub/docs/manual-ocaml/libref/Array.html
  
  * `Stack` : https://caml.inria.fr/pub/docs/manual-ocaml/libref/Stack.html
  
  * `List` : https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html
  
Découpage modulaire
-------------------

Le projet est composé de 3 modules `systems.ml`, `turtle.ml`, `examples.ml` et de leurs fichiers `.mli` respectifs, et d'un fichier `main.ml` comprenant la fonction principale qui exécute notre programme appelée dans une fonction `main`. Nous n'avons pas trouvé d'intêret à ajouter des modules supplémentaires à ceux qui étaient déjà fournis.

Organisation du travail
-----------------------

Nous avons essayé d'organiser le travail au mieux entre nous et au plus vite, afin d'éviter de prendre du retard (sachant que ce semestre était plutôt chargé). Nous avons commencé par lire le sujet dès qu'il était disponible pour avoir le temps de bien y réfléchir avant de se lancer dans l'implémentation. Après avoir dressé l'architecture de base du projet (qui était modulable), et les premiers algorithmes nécéssaires à l'exécution du programme, nous nous sommes répartis les tâches équitablement et de manière logique. Au final, quand on regarde nos 2 contributions au projet voici ce qu'il en est :

* GERGES Samuel :
   * implémentation de toutes les fonctions contenu dans le fichier `turtle.ml`
   * implémentation de la fonction `cast`
   * ajout du type `'s sytem_properties`
   * ajout d'exemples de L-systèmes

* JAMI Adam :
   * implémentation des fonctions `substitute` et `substitute_n`
   * implémentation de la fonction `interaction`
   * ajout d'exemples de L-systèmes

Nous nous réunissions plus ou moins 1H30 presque chaque vendredi soir ("presque" car il y'a eu des moments d'indisponibilité) pour échanger par rapport au projet et à notre avancement dans nos tâches respectives.

Misc
----

**Quelques petites remarques :**

* Je (Adam Jami) n'ai pas pu être très actif sur le GitLab en raison de différents problèmes (principalement l'impossibilité de tester le projet sur ma machine). De plus, la machine que j'ai pu emprunter à l'université rencontrait souvent des problèmes techniques (impossibilité de mettre à jour dune ou opam malgré les recherches). Les années précédentes je faisais le plus souvent mes commits sur les machines du script. Toutes les tâches que j'ai effectuées ont été envoyées à Samuel pour qu'il les commit lui-même. Merci de votre compréhension.

* L'activité générale du GitLab n'est pas forcément soignée étant donnés les problèmes rencontrés par Adam et que, nous ne pensions pas que ce serait un critère d'évaluation. Pour nous GitLab est seulement un outil à notre disposition pour bien travailler en groupe, et puisque l'un des deux membres du groupe était indisposé cela n'était plus notre priorité de faire attention à l'activité du GitLab.

* Par rapport à la génération des figures représentant les L-systèmes : nous en avions déjà parlé à M. Letouzey, mais les tests que l'on fait sur ma machine (Gerges Samuel), Adam ne pouvant pas tester le projet sur sa machine à cause d'un problème de bibliothèque `opam`, présentent de légers bugs d'affichages. En effet, la figure est correcte mais selon l'itération elle peut mettre du temps à charger, ou même s'afficher partiellement (dans ce cas il faut passer la souris sur la figure pour qu'elle s'affiche complétement...). Je ne sais pas d'où cela provient mais je compose sur une machine virtuelle, peut-être que ça a à voir là-dedans. C'était seulement pour vous en tenir au courant au cas où le même phénomène se produisait chez vous également.

Bons tests !


