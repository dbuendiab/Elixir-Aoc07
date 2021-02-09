defmodule Aoc07 do
  @moduledoc """
  Documentation for `Aoc07`.
  Se trata de leer un fichero de datos 'aoc.txt' un árbol de distribución de maletas anidadas,
  y calcular cuántas maletas en total hay dentro de un tipo de maleta dado.
  En primer lugar debemos leer los datos en un diccionario: %{maleta => [nodo de maletas anidadas,...]}.
  """

  # import Util.Diccionario
  # alias Util.Diccionario

  def cargar_diccionario(ruta \\ "lib/aoc.txt"), do: Util.Diccionario.load(ruta)

  def maletas_dentro_de(diccionario, color), do: cuantas_maletas(diccionario, color, 0)

  defp cuantas_maletas(diccionario, color, acumulado) do
    # IO.write color <> " -> "
    # IO.inspect
    lista_submaletas = Map.get(diccionario, color)

    case lista_submaletas do
      [nil: 0] ->
        # IO.puts "No sigo por aqui"
        acumulado

      _ ->
        num_maletas = reduce_lista_submaletas(lista_submaletas)
        # IO.write color <> " - Num. maletas --> "
        # IO.inspect num_maletas

        num_submaletas =
          Enum.reduce(lista_submaletas, 0, fn {color, cuantas}, acc ->
            ## Aquí "cuantas" es para multiplicar por lo que venga de más adentro del árbol
            acc + cuantas * cuantas_maletas(diccionario, color, acumulado)
          end)

        # IO.write color <> " - Num. submaletas ----> "
        # IO.inspect num_submaletas

        # IO.write color <> " - TOTAL maletas ------> "
        # IO.inspect
        acumulado + num_maletas + num_submaletas
    end
  end

  defp reduce_lista_submaletas(lista_submaletas) do
    Enum.reduce(lista_submaletas, 0, fn {_color, num}, acc ->
      acc + num
    end)
  end

  def print_recursive(diccionario, nivel, maleta \\ "shiny gold") do
    submaletas = Map.get(diccionario, maleta)
    tabs = String.duplicate("..", nivel)

    case submaletas do
      nil ->
        # IO.puts tabs <> "Nil -> 0"
        nil

      [nil: 1] ->
        IO.puts(tabs <> maleta <> " -> nil: 1")

      [nil: 0] ->
        IO.puts(tabs <> maleta <> " -> nil: 0")

      [{color, cantidad}] ->
        IO.puts(tabs <> maleta <> " -> " <> "#{color}: #{cantidad}")
        print_recursive(diccionario, nivel + 1, color)

      lista when is_list(lista) ->
        salida =
          Enum.map(lista, fn {color, cantidad} -> "#{color}: #{cantidad}" end)
          |> Enum.join("; ")

        IO.puts(tabs <> maleta <> " -> " <> salida)
        Enum.each(lista, &print_recursive(diccionario, nivel + 1, elem(&1, 0)))
    end
  end

  def main do
    argumentos = System.argv()

    case length(argumentos) do
      0 ->
        IO.puts("Argumentos: color --diccionario --recursivo --todo")

      _ ->
        flag_dicc = "--diccionario" in argumentos
        flag_print = "--recursivo" in argumentos
        flag_todo = "--todo" in argumentos
        [color | _] = argumentos

        diccionario = Aoc07.cargar_diccionario()

        IO.puts("MALETAS DENTRO DE " <> String.upcase(color))
        IO.inspect(Aoc07.maletas_dentro_de(diccionario, color))

        if flag_dicc do
          IO.puts("DICCIONARIO")
          IO.inspect(diccionario)
          IO.puts("")
        end

        if flag_print do
          IO.puts("IMPRESION RECURSIVA")
          Aoc07.print_recursive(diccionario, 0, color)
        end

        if flag_todo do
          underscoring = fn n ->
            n
            |> Integer.to_string()
            |> String.reverse()
            |> String.to_charlist()
            |> Enum.chunk_every(3)
            |> Enum.join("_")
            |> String.reverse()
          end

          Enum.map(diccionario, fn {k, _v} -> {k, Aoc07.maletas_dentro_de(diccionario, k)} end)
          |> Enum.reduce([], fn x, acc -> [x | acc] end)
          |> Enum.sort(fn a, b -> elem(a, 1) < elem(b, 1) end)
          |> Enum.each(fn x -> IO.puts("#{elem(x, 0)}: #{underscoring.(elem(x, 1))}") end)
        end
    end
  end
end
