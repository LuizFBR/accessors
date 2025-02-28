:- module(accessors, []).

:- use_module(library(clpfd)).
:- set_prolog_flag(clpfd_monotonic, true).

:- multifile user:term_expansion/2.
:- dynamic user:term_expansion/2.

user:term_expansion((:- derive_accessors(Predicate)), Clauses) :-
    predicate_accessors(Predicate, Clauses).

user:term_expansion((:- derive_accessors(PredName, ArgNamesList)), Clauses) :-
    predname_accessors(PredName, ArgNamesList, Clauses).

predname_accessors(_,[],[]).
predname_accessors(PredName, [ArgName | ArgsTail],[ Term | ClausesTail]) :-
    phrase(list_accessor(PredName,ArgName),L),
    atomics_to_string(L,S),
    atom_to_term(S,Term,_),
    predname_accessors(PredName,ArgsTail,ClausesTail).

predicate_accessors(Pred,Clauses) :-
    Pred =.. [PredName | ArgNamesList],
    length(ArgNamesList,Arity),
    predname_accessors(PredName,Arity,ArgNamesList,Clauses).

predname_accessors(_,_,[],[]). 
predname_accessors(PredName,Arity,[Name|NamesTail],[Term | TermsListTail]) :-
    length(NamesTail, NumberOfRemainingNames),
    #(Index) #= #(Arity) - #(NumberOfRemainingNames),
    phrase(accessor(PredName,Arity,Name,Index),L),
    atomics_to_string(L,S),
    atom_to_term(S,Term,_),
    predname_accessors(PredName,Arity,NamesTail,TermsListTail).

list_accessor(PredName,Name) -->
    ['\''],[PredName],['_'],[Name],['\''], ['(_ListPair,_'],[Name],[') :- \n\t'],
        ['member('],[Name],['-_'],[Name],[',_ListPair).'].

accessor(PredName,Arity,Name,Index) -->
    ['\''],[PredName],['_'],[Name],['\'('],pred(PredName,Arity,Index,Name),[',_'],[Name],[').'].

pred(PredName,Arity,Index,Name) -->
    ['\''],[PredName],['\'('], pred_rest(Arity,Index,1,Name).

pred_rest(Arity, Index, Acc, Name) -->
    (
        {#(Acc) #= #(Index)}, ['_'], [Name]
        ;
        {#(Acc) #\= #(Index)}, ['_']
    )
    ,
    (
        {#(Acc) #= #(Arity)}, [')']
        ;
        {#(Acc) #\= #(Arity)}, [','], {#(Acc1) #= #(Acc) + 1} , pred_rest(Arity,Index,Acc1,Name)
    ).
