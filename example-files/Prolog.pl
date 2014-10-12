/* append 2 lists */
app([],L2,L2).
app([Head|Tail],L2,[Head|Result]) :- app(Tail,L2,Result).

/* reverse a list */
rev([],[]).
rev([H|T],Result) :-
    rev(T,X),
    app(X,[H],Result).

/* deletes all occurences of a specified item at the top level of a list */
del(X,[],[]).
del(X,[X|T],R) :- del(X,T,R).
del(X,[H|T],[H|R]) :- X \== H, del(X,T,R).

/* count all atoms in a list including nested lists */
countAll([],0).
countAll(X,1).
countAll([H|T],N) :-
    countAll(H,N1),     /* count sublists in head */
    countAll(T,N2),     /* count sublists in tail */
    N is N1 + N2.       /* add the counts */

/* delete all occurences of a specified item at all levels of a list */
deleteAll(X,[],[]).
deleteAll(X,[X|T],R) :- deleteAll(X,T,R).
deleteAll(X,[H|T],[H|R]) :- X \== H, deleteAll(X,T,R).
deleteAll(X,[H|T],[R1|R2]) :-
    deleteAll(X,H,R1),
    deleteAll(X,T,R2).

/* flatten a nested list while retaining nested ordering */
flatten([],[]).
flatten([A|L],[A|L1]) :- flatten(L,L1).
flatten([A|L],R) :-
    flatten(A,A1),
    flatten(L,L1),
    app(A1,L1,R).

    
/*
 * mergesort merge step
 * Sample Use: merge([1,3,8],[2,4,5],X) returns [1,2,3,4,5,8]
 */
merge([],[]).
merge([],L,L).
merge(L,[],L).

/*
 * smaller head of L1,L2 is head of Result
 * if L1.Head <= L2.Head, then:
 */
merge([H1|T1],[H2|T2],[H1|R]) :-
    H1 =< H2,               /* L1 head is smaller */
    merge(T1,[H2|T2],R).    /* keep merging without L1 head */

/*
smaller head of L1,L2 is head of Result
if L2.Head < L1.Head, then:
*/
merge([H1|T1],[H2|T2],[H2|R]) :-
    H1 > H2,                /* L2 head is smaller */
    merge([H1|T1],T2,R).    /* keep merging without L2 head */
