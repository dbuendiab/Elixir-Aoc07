defmodule UtilDiccionarioTest do
  use ExUnit.Case
  doctest Aoc07

  describe "Util.Diccionario.desglose/1 -" do
    test "desglose de maletas con número" do
      assert Util.Diccionario.desglose("5 drab brown bags") == {"drab brown", 5}
    end

    test "desglose de maletas sin número" do
      assert Util.Diccionario.desglose("no other bags.") == {nil, 0}
    end
  end

  ## --------------------------------------------------------------------------

  describe "Util.Diccionario.contenido/1 -" do
    test "contenido de maletas (múltiple)" do
      assert Util.Diccionario.def_contenido(
               "1 dull gray bag, 1 dull lavender bag, 1 mirrored green bag, 2 muted maroon bags."
             ) ==
               [{"dull gray", 1}, {"dull lavender", 1}, {"mirrored green", 1},
                {"muted maroon", 2}]
    end

    test "contenido de maletas (única)" do
      assert Util.Diccionario.def_contenido("4 dim violet bags.") ==
               [{"dim violet", 4}]
    end

    test "contenido de maletas (vacío)" do
      assert Util.Diccionario.def_contenido("no other bags.") ==
        [{nil, 0}]
    end
  end

  ## --------------------------------------------------------------------------

  describe "Util.Diccionario.def_maleta/1 -" do
    test "definición de maletas (varias)" do
      assert Util.Diccionario.def_maleta(
               "wavy chartreuse bags contain 1 dull gray bag, 1 dull lavender bag, 1 mirrored green bag, 2 muted maroon bags."
             ) ==
               %{
                 "wavy chartreuse" =>
                   [{"dull gray", 1}, {"dull lavender", 1}, {"mirrored green",1},
                    {"muted maroon",2}]
               }
    end

    test "definición de maletas (ninguna)" do
      assert Util.Diccionario.def_maleta("pale salmon bags contain no other bags.") ==
               %{"pale salmon" => [nil: 0]}
    end

    test "definición de maletas (una)" do
      assert Util.Diccionario.def_maleta("vibrant violet bags contain 4 dim violet bags.") ==
               %{"vibrant violet" => [{"dim violet", 4}]}
    end
  end
end
