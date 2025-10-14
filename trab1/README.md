# L-System with Elixir!

Builiding an L-System with elixir and printing the result in a python program.

## How does it works?

An L-System can be defined as a tuple G = (V, w, P),
where
V - (the  *alphabet* ) is a set of symbols containing both elements that can be replaced ( *variables* ) and those which cannot be replaced ("constants" or "terminals")

w - ( *start* , *axiom* or  *initiator* ) is a string of symbols from V defining the initial state of the system

P - is a set of production rules or *Production (computer science)")* or *productions*
 defining the way variables can be replaced with combinations of
constants and other variables. A production consists of two strings, the
 *predecessor* and the  *successor* . For any symbol A which is a
 member of the set V which does not appear on the left hand side of a
production in P, the identity production A → A is assumed; these symbols
 are called *constants* or  *terminals* .

With a tuple in mind, as long as you have the rules defined as function and the correct axiom, just run the function fractal, which receives a natural number. It will apply the rules n times and tell the result.
