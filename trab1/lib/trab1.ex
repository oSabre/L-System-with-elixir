defmodule Trab do
  # L-System is defined as a tuple G = (V, w, P)
  # Where V is the alphabet containing variables and terminals
  # w is an axiom, a string of symbols from V that defines the inital state
  # P are the production rules for substitution
  # Let's do V = (I, F, G, +25, -25, +50, -50, [,])
  # w = I
  # P contains the following:
  # I -> [F][+25F][-25F]
  # F -> [+50 G +50 G][-50 G -50 G]
  # G -> F -25 F
  def axiom, do: "I"

  def i do
    "[F][+25F][-25F]"
  end

  def f do
    "[+50G +50G][-50G -50G]"
  end

  def g do
    "F-25F"
  end

  def fractal(n) when is_integer(n) and n>=0 do
    aux_fractal(axiom(), n)
  end

  def aux_fractal(minhaString, 0), do: minhaString

  def aux_fractal(minhaString, n) do
    #aplica a regra
    continua = substitui(minhaString)
    aux_fractal(continua, n-1)
  end

  def substitui(minhaString) do
    minhaString<>"chiro"
  end

end
