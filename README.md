# Prolog Automatic Accessors

Relational predicate accessors generators that allows easy and efficient access to term arguments by name.

This library provides the user with a `:- derive_accessors/1` prolog directive that automatically generates relational predicates that associate a predicate with each of its arguments.

## Installation

To install the fld library, type the following in the SWI-Prolog shell:

```Prolog
pack_install('accessors').
  true.
```

## Example

`:- derive_accessors(pred(a,b,c)).`

Will generate the following static predicates globally:

```Prolog
pred_a(pred(A,_,_),A).
pred_b(pred(_,B,_),B).
pred_c(pred(_,_,C),C).
```

## Importing

Import this module with

```Prolog
:- use_module(library(accessors)).
```

## Dependencies

This library depends on Markus Triskas' clpfd library.