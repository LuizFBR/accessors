:- use_module('../prolog/accessors').

:- derive_accessors(pred(a,b,c)).
:- derive_accessors('composite name'(a,b,c)).

:- begin_tests(derive_accessors_directive).

test(simple_atom) :-
    Pred = pred(a,b,c),
    pred_a(Pred,a),
    pred_b(Pred,b),
    pred_c(Pred,c).

test(composite_atom) :-
    Pred = 'composite name'(a,b,c),
    'composite name_a'(Pred,a),
    'composite name_b'(Pred,b),
    'composite name_c'(Pred,c).

test(monotonicity) :-
    Pred1 = pred(a,b,c),
    Pred2 = 'composite name'(a,b,c),
    pred_a(Pred1,a),
    'composite name_a'(Pred2,a),
    pred_a(Pred1,a).

% test(purity) :- How to test for purity?
%     Pred1 = pred(X,Y,Z),
%     pred_a(Pred,A),
%     pred_a(Pred,B).

:- end_tests(derive_accessors_directive).