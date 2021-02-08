defmodule Diccionario do
  @moduledoc """
  Convierte un fichero de texto con el formato adecuado en
  una lista de entradas del diccionario de maletas de colores

  El formato es, por ejemplo:
  ```
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags.
  bright white bags contain 1 shiny gold bag.
  ```

  Una maleta puede contener 0, 1 o varias maletas en su interior

  ## Ejemplos

  iex> 1 + 1
  2

  """

  @doc """
  A partir del nombre de un fichero de texto con formato diccionario
  genera el diccionario correspondiente. Tal como está diseñado el
  proyecto, las rutas son "lib\\fich.txt" en Windows (y el separador
  de líneas es CRLF)
  """
  def load(ruta_fichero) do
    acc = %{}
    File.read!(ruta_fichero)
    |> String.split("\r\n", trim: true)
    |> Enum.map(&(def_maleta(&1)))
    |> Enum.reduce(acc, fn x, acc -> Map.merge(acc, x) end)
  end

  defp def_maleta(linea) do
    separador = " bags contain "
    [maleta, maletas_interior] = String.split(linea, separador, trim: true)
    otras_maletas = def_contenido(maletas_interior)
    %{maleta => otras_maletas}
  end

  defp def_contenido(cadena) do
    String.split(cadena, ", ")  ## El espacio después de la coma es importante (para que el número)
    |> Enum.map(&(desglose(&1)))
  end

  defp desglose(item) do
    elems = String.split(item, " ")
    [first | resto] = elems
    case Integer.parse(first) do
      ## Caso "no other...", no empieza por número, luego parse da error
      :error -> {nil, 0}
      ## Caso "5..., parse da una tupla con el número y lo que sobre de la cadena
      ## Los hd(), tl() es para sacar los siguientes elementos de la lista,
      ## podía usar también Enum.at(lista, index)
      {num, _} -> {hd(resto) <> " " <> hd(tl(resto)), num}
    end
  end


end
