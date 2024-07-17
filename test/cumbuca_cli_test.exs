defmodule CumbucaCLITest do
  use ExUnit.Case
  doctest CumbucaCLI

  test "assign_roman_numerals_to_names with an empty list" do
    names = []
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == []
  end

  test "assign_roman_numerals_to_names with a single name Pedro" do
    names = ["Pedro"]
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == ["Pedro I"]
  end

  test "assign_roman_numerals_to_names with repeated names" do
    names = ["Polvo", "Polvo", "Polvo", "Polvo", "Polvo"]
    expected = ["Polvo I", "Polvo II", "Polvo III", "Polvo IV", "Polvo V"]
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == expected
  end

  test "assign_roman_numerals_to_names with random names" do
    names = ["Joao", "Pedro", "Joao", "Maria", "Pedro", "Joao"]
    expected = ["Joao I", "Pedro I", "Joao II", "Maria I", "Pedro II", "Joao III"]
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == expected
  end

  test "assign_roman_numerals_to_names with mixed case names and normalization" do
    names = ["Joao", "joao", "Pedro", "pEDRO", "Maria", "mARIA", "Joao", "jOAO"]

    expected = [
      "Joao I",
      "Joao II",
      "Pedro I",
      "Pedro II",
      "Maria I",
      "Maria II",
      "Joao III",
      "Joao IV"
    ]

    result =
      names
      |> Enum.map(&CumbucaCLI.normalize_name/1)
      |> CumbucaCLI.assign_roman_numerals_to_names()

    assert result == expected
  end

  test "assign_roman_numerals_to_names with 192 repetitions of Pedro" do
    names = Enum.map(1..192, fn _ -> "Pedro" end)
    expected = Enum.map(1..192, fn n -> "Pedro #{CumbucaCLI.to_roman(n)}" end)
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == expected
  end

  test "assign_roman_numerals_to_names with 2048 repetitions of Pedro and Castilho" do
    names =
      Enum.concat(
        Enum.map(1..2048, fn _ -> "Pedro" end),
        Enum.map(1..2048, fn _ -> "Castilho" end)
      )

    expected_pedro = Enum.map(1..2048, fn n -> "Pedro #{CumbucaCLI.to_roman(n)}" end)
    expected_castilho = Enum.map(1..2048, fn n -> "Castilho #{CumbucaCLI.to_roman(n)}" end)
    expected = Enum.concat(expected_pedro, expected_castilho)
    assert CumbucaCLI.assign_roman_numerals_to_names(names) == expected
  end

  test "assign_roman_numerals_to_names with 3878 repetitions of Pedro, Castilho, and Polvo" do
    names_pedro = Enum.map(1..3878, fn _ -> "Pedro" end)
    names_castilho = Enum.map(1..3878, fn _ -> "Castilho" end)
    names_polvo = Enum.map(1..3878, fn _ -> "Polvo" end)

    names = names_pedro ++ names_castilho ++ names_polvo

    normalized_names = Enum.map(names, &CumbucaCLI.normalize_name/1)

    expected_pedro = Enum.map(1..3878, fn n -> "Pedro #{CumbucaCLI.to_roman(n)}" end)
    expected_castilho = Enum.map(1..3878, fn n -> "Castilho #{CumbucaCLI.to_roman(n)}" end)
    expected_polvo = Enum.map(1..3878, fn n -> "Polvo #{CumbucaCLI.to_roman(n)}" end)

    expected = expected_pedro ++ expected_castilho ++ expected_polvo

    assert CumbucaCLI.assign_roman_numerals_to_names(normalized_names) == expected

    assert CumbucaCLI.to_roman(3878) == "MMMDCCCLXXVIII"
  end

  test "assign_roman_numerals_to_names with Joao repeated 9999 times" do
    names = Enum.map(1..9999, fn _ -> "Joao" end)
    expected = Enum.map(1..9999, fn n -> "Joao #{CumbucaCLI.to_roman(n)}" end)
    result = CumbucaCLI.assign_roman_numerals_to_names(names)

    assert result == expected

    assert CumbucaCLI.to_roman(9999) == "MMMMMMMMMCMXCIX"
  end
end
