defmodule Aoc07Test do
  use ExUnit.Case
  doctest Aoc07

  describe "Aoc07.desglose/1 -" do
    test "desglose de maletas con número" do
      assert Aoc07.desglose("5 drab brown bags") == {5, "drab brown"}
    end

    test "desglose de maletas sin número" do
      assert Aoc07.desglose("no other bags.") == {0, nil}
    end
  end
  ## --------------------------------------------------------------------------

  describe "Aoc07.contenido/1 -" do
    test "contenido de maletas (múltiple)" do
      assert Aoc07.contenido("1 dull gray bag, 1 dull lavender bag, 1 mirrored green bag, 2 muted maroon bags.") ==
            {{1, "dull gray"}, {1, "dull lavender"}, {1, "mirrored green"}, {2, "muted maroon"}}
    end

    test "contenido de maletas (única)" do
      assert Aoc07.contenido("4 dim violet bags.") ==
            {{4, "dim violet"}}
    end

    test "contenido de maletas (vacío)" do
      assert Aoc07.contenido("no other bags.") ==
            {{1, nil}}
    end
  end
  ## --------------------------------------------------------------------------

  describe "Aoc07.def_maleta/1 -" do
    test "definición de maletas (varias)" do
      assert Aoc07.def_maleta("wavy chartreuse bags contain 1 dull gray bag, 1 dull lavender bag, 1 mirrored green bag, 2 muted maroon bags.") ==
            %{"wavy chartreuse" => {{1, "dull gray"}, {1, "dull lavender"}, {1, "mirrored green"}, {2, "muted maroon"}}}
    end

    test "definición de maletas (ninguna)" do
      assert Aoc07.def_maleta("pale salmon bags contain no other bags.") ==
            %{"pale salmon" => {{1, nil}}}
    end

    test "definición de maletas (una)" do
      assert Aoc07.def_maleta("vibrant violet bags contain 4 dim violet bags.") ==
            %{"vibrant violet" => {{4, "dim violet"}}}
    end
  end
end
