defmodule Trab do
  # Trab.fractal(0, {["a","b"], ["a"],%{"a"=>["a","b"], "b"=>["a"]}})
  def fractal(n, {_v,w,p}) when is_integer(n) and n>= 0 do
    turtle(aux_fractal(w,n,p))
  end

  def aux_fractal(producao, 0, _p), do: producao

  def aux_fractal(producao, n, p) do
    continua = substitui(producao, p)
    aux_fractal(continua, n-1, p)
  end

  def substitui(producao, p) do
    Enum.flat_map(producao, fn x ->
      case Map.fetch(p,x) do
        {:ok, prod} -> prod
        :error -> [x]
      end
    end)
  end

  def turtle(producao) do
    producao
  end
end
