:- module(accessors, []).

:- use_module(library(clpfd)).
:- set_prolog_flag(clpfd_monotonic, true).

:- multifile user:term_expansion/2.
:- dynamic user:term_expansion/2.

user:term_expansion((:- derive_accessors(Predicate)), Clauses) :-
    derive_accessors(Predicate, Clauses).

derive_accessors(Pred,Clauses) :-
    Pred =.. [PredName | ArgList],
    length(ArgList,Arity),
    derive_all_accessors(PredName,Arity,ArgList,Clauses).

derive_all_accessors(_,_,[],[]). 
derive_all_accessors(PredName,Arity,[Name|NamesTail],[Term | TermsListTail]) :-
    length(NamesTail, NumberOfRemainingNames),
    #(Index) #= #(Arity) - #(NumberOfRemainingNames),
    phrase(accessor(PredName,Arity,Name,Index),L),
    atomics_to_string(L,S),
    % write(S),nl,
    atom_to_term(S,Term,_),
    % write(Term),nl,
    derive_all_accessors(PredName,Arity,NamesTail,TermsListTail).

accessor(PredName,Arity,Name,Index) -->
    ['\''],[PredName],['_'],[Name],['\''], ['('],pred(PredName,Arity,Index,Name),[',_'],[Name],[').'].

pred(PredName,Arity,Index,Name) -->
    ['\''],[PredName],['\''], ['('], pred_rest(Arity,Index,1,Name).

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
