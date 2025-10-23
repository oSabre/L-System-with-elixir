defmodule Trab do
  # Trab.fractal(0, {["a","b"], ["a"],%{"a"=>["a","b"], "b"=>["a"]}})
  # Trab.turtle(1, {["a","b"], ["a"],%{"a"=>["a","b"], "b"=>["a"]}})
  # Trab.turtle(1, {["F","G"], ["F"],%{"F"=>["F","G"], "G"=>["F","+30","-30"]}})
  # Trab.turtle(1, {["F"],["F"],%{"F"=>["F", "+60", "F", "-120", "F", "+60", "F"]}})
  # Trab.turtle(1, {["F", "G"], ["G"], %{"F" => ["F"], "G" => ["F","[","+25","G","]","[","-25","G","]","F","G"]}})

  #Relativos ao problema 1
  def fractal(n, {_v,w,p}) when is_integer(n) and n>= 0 do
    aux_fractal(w,n,p)
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

  #Problema 3
  def checkprod(producao, n, {v, w,p}) do
    producao == fractal(n, {v,w,p})
  end

  # Problema 2
  def turtle(n, {_v,w,p}) when is_integer(n) and n>= 0 do
    producao = aux_fractal(w,n,p)
    codigo = gerador_codigo(producao)

    case File.write("turtleCode.py", codigo) do
      :ok -> {:ok, "Arquivo Gerado"}
      {:error, erro} -> {:error, "Deu problema. Erro: #{erro}"}
    end
  end

  defp gerador_codigo(producao) do
    header =
      """
      import turtle
      import math

      t = turtle.Turtle()
      t.screen.setup(width=1920, height=1080)
      t.speed(0)
      t.penup()
      t.goto(0,-300)
      t.setheading(90.0)
      t.pendown()

      F_LEN = 20.0
      G_LEN = 30.0
      PEN_STACK = []

      """

    commands = Enum.map(producao, &producao_to_python/1)
    body = Enum.join(commands, "\n")

    footer = "\n\nt.screen.exitonclick()"

    header <> body <> footer
  end

  defp producao_to_python(prod) do
    case prod do
      "F" -> "t.pencolor('blue')\nt.forward(F_LEN)"
      "G" -> "t.pencolor('red')\nt.forward(G_LEN)"
      "[" -> "PEN_STACK.append((t.heading(), t.pos()))\nt.penup()"
      "]" -> """
            if PEN_STACK:
              heading, pos = PEN_STACK.pop()
              t.setheading(heading)
              t.goto(pos)
              t.pendown()
            """
      "+"<> rest -> angle = String.to_integer(rest)
            "t.right(#{angle})"
      "-"<> rest -> angle = String.to_integer(rest)
            "t.left(#{angle})"
      " " -> ""
      _ -> "# Comando não reconhecido: #{prod}"
    end
  end

end
