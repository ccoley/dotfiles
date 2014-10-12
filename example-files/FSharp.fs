//
// Simple Functions - SimpleFunctions.fs
// by: Chris Coley
//

// 4.01
let addTwo a = a + 2;;
let cube a = a*a*a;;
let cubeAddTwo a = cube (addTwo a);;
let addTwoCube a = addTwo (cube a);;

addTwo 2;; // Should return 4
cube 2;; // Should return 8
cubeAddTwo 2;; // Should return 64
addTwoCube 2;; // Should return 10

// 4.02  Each function should print odds from 1 to (n + n-3)
let comp1 n = [for a in 2..n do yield! [(a-1) + (a-2)]];;
let comp2 n = [1..2..(n + n-3)];;

comp1 20;; // should be odds [1-37]
comp2 20;; // should be odds [1-37]
comp1 30;; // should be odds [1-57]
comp2 30;; // should be odds [1-57]

// 4.03
let rec isMember item lst =
    if lst = [] then false
    else if (List.head lst) = item then true
    else isMember item (List.tail lst);;

isMember 5 [1;2;3;4;5;6;7;8;9];; // Should return true
isMember 5 [1;2;3;4;6;7;8;9];; // Should return false

// 4.04
let rec deleteFirst item lst =
    if lst = [] then lst
    else if (List.head lst) = item then (List.tail lst)
    else (List.head lst) :: deleteFirst item (List.tail lst);;

deleteFirst 10 [8;6;7;10;5;3;0;9];; // should return Jenny's number
deleteFirst 10 [1..9];; // should return [1-9]
deleteFirst 10 [];; // should return empty list

// 4.05
let rec quicksort list =
    match list with
    | [] -> []
    | hd::tr -> quicksort (List.filter (fun x -> x < hd) tr) @ hd :: quicksort (List.filter (fun x -> x >= hd) tr);;

quicksort [8;76;56;3456;345;78;67;76;56;76;123;2;456;97654;87;32;432];; // Handles Duplicates
quicksort [2;2;2;2;2;2];; // All duplicates

// 4.06
let rec zip L1 L2 =
    match L1 with
        | [] -> []
        | hd::tl -> let r = zip tl (List.tail L2)
                    (hd, List.head L2)::r;;
let abc123 = zip [1..3] ['a'..'c'];;

let rec unzip lst =
    match lst with
    | [] -> ([],[])
    | hd::tl -> let r = unzip tl
                (fst hd)::(fst r), (snd hd)::(snd r);;

unzip abc123;;  // Should return lists from previous zip.

// 4.07
let rec partition func list =
    match list with
    | [] -> ([],[])
    | hd::tr -> 
        let r = partition func tr
        if (func hd) then (hd::fst r, snd r)
        else (fst r, hd::snd r);;

partition (fun n -> n % 2 = 0) [6;3;5;9;8;4;2;1;9];; // returns even set and odd set
partition (fun n -> n % 2 = 0) [1;3;5;7];; // returns empty set and odd set
partition (fun n -> n % 2 = 0) [];; // returns 2 empty sets

// 4.08
let rec checkForTrue lst =
    if lst = [] then false
    else
        if List.head lst = true then true
        else
            checkForTrue (List.tail lst);;

let doesAnyElementSatisfy func lst =
    (List.map func lst) |> checkForTrue;;  // Pipe into checkForTrue

doesAnyElementSatisfy (fun n -> n % 2 = 0) [1;2;3;4;5;6];; // returns true
doesAnyElementSatisfy (fun n -> n % 2 = 0) [1;3;5];; // returns false
doesAnyElementSatisfy (fun n -> n % 2 = 0) [];; // returns false

let rec checkForAllTrue lst =
    if lst = [] then true 
    else
        if List.head lst = false then false
        else
            checkForAllTrue (List.tail lst);;

let doAllElementsSatisfy func lst =
    if lst = [] then false
    else
        (List.map func lst) |> checkForAllTrue;;  // Pipe into checkForAllTrue

doAllElementsSatisfy (fun n-> n % 2 = 0) [1..10];; // returns false
doAllElementsSatisfy (fun n-> n % 2 = 0) [2;4;6;8];; // returns true
doAllElementsSatisfy (fun n-> n % 2 = 0) [];; // returns false

let rec addTrue lst =
    if lst = [] then 0
    else
        if List.head lst = true then 1 + addTrue (List.tail lst)
        else
            0 + addTrue (List.tail lst);;

let countElementsThatSatisfy func lst =
    if lst = [] then 0
    else
        (List.map func lst) |> addTrue;; // Pipe to addTrue

countElementsThatSatisfy (fun n -> n % 2 = 0) [1;2;3;4;6];; // returns 3
countElementsThatSatisfy (fun n -> n % 2 = 0) [1;3;5];; // returns 0
countElementsThatSatisfy (fun n -> n % 2 = 0) [];; // returns 0

// 4.09
type SLList =
    | Node of int * SLList
    | Empty

let rec add value lst =
    match lst with
        | Empty -> Node(value, Empty)
        | Node(v, link) -> Node(v, add value link);;

let L1 = add 3 (add 1 (add 4 (add 2 Empty)));;
let L2 = add 1 Empty;;
let L3 = add 3 (add 1 (add 4 (add 18(add 99(add 100(add 0(add 2 Empty)))))));;

let countElements sllist =
    let rec counter sllist count =
        match sllist with
            | Empty -> count
            | Node(v, link) -> counter link (count+1)
    counter sllist 0;;

countElements L1;; // returns 4
countElements L2;; // returns 1
countElements L3;; // returns 8

// 4.10 - Does not work with generics.
type BinarySearchTree =
    | Node of int * BinarySearchTree * BinarySearchTree
    | Empty;;

type BinTree<'T> when 'T : comparison =   // Should be generic Binary Tree, but I can't figure out how to do it
    | SetEmpty                                         
    | SetNode of 'T * BinTree<'T> *  BinTree<'T>;;

let rec bstAdd value bst =
    match bst with
        | Node (data, left, right)
            -> if value < data then 
                  Node(data, (bstAdd value left), right)
               elif value > data then 
                  Node(data, left, (bstAdd value right))
                else bst
        | Empty -> Node(value, Empty, Empty);

let T1 = bstAdd 5 (bstAdd 7 (bstAdd 4 (bstAdd 8 (bstAdd 6 Empty))));
let T2 = bstAdd 7 (bstAdd 5 (bstAdd 6 (bstAdd 4 (bstAdd 8 Empty))));

let rec postTraverse tree =
    match tree with
        | Node(data, left, right)
            -> postTraverse left
               postTraverse right
               printfn "Node %d" data
        | Empty
            -> ();;

postTraverse T1;;  // returns 5, 4, 7, 8, 6
postTraverse T2;;  // returns 5, 7, 6, 4, 8