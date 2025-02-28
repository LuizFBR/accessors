# Prolog Automatic Accessors

Relational predicate accessors generators that allows easy and efficient access to term and pairs-lists arguments by name.

This library provides the user with the `:- derive_accessors/1` and `:- derive_accessors/2` prolog directives that automatically generate relational predicates that associate a predicate/pairs-list with each of its arguments.

The choice of imperative naming for `:- derive_accessors` was to keep this library user-friendly for users who are used to imperative programming.

To-do:
- Test for purity;

## Installation

To install the fld library, type the following in the SWI-Prolog shell:

```Prolog
? - pack_install('accessors').
  true.
```
or, alternatively, you can install directly from this github repo:

```Prolog
?- pack_install('https://github.com/LuizFBR/accessors.git').
  true.
```

## Example

### Predicate accessors

The directive call:

`:- derive_accessors(pred(a,b,c)).`

will generate the following static predicate accessors globally:

```Prolog
pred_a(pred(A,_,_),A).
pred_b(pred(_,B,_),B).
pred_c(pred(_,_,C),C).
```

### Pairs-List Accessors

The directive call:

`:- derive_accessors(pred, [a,b,c]).`

will generate the following static pairs-list accessors at compile-time:

```Prolog
fact_a(_ListPair,_a) :-
    member(a-_a,_ListPair).
fact_b(_ListPair,_b) :-
    member(b-_b,_ListPair).
fact_c(_ListPair,_c) :-
    member(c-_c,_ListPair).
```

## Importing

Import this module with

```Prolog
:- use_module(library(accessors)).
```

## Dependencies

This library depends on Markus Triskas' clpfd library:

https://www.swi-prolog.org/man/clpfd.html