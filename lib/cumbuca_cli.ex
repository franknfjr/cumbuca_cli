defmodule CumbucaCLI do
  @moduledoc """
  CLI para numerar reis e rainhas de Cumbúquia.

  ## Examples

      iex> CumbucaCLI.assign_roman_numerals_to_names([])
      []

      iex> CumbucaCLI.assign_roman_numerals_to_names(["Pedro"])
      ["Pedro I"]

      iex> CumbucaCLI.assign_roman_numerals_to_names(["João", "João", "João"])
      ["João I", "João II", "João III"]

      iex> CumbucaCLI.assign_roman_numerals_to_names(["Maria", "Beatriz", "Carlos", "Maria", "Carlos", "Beatriz", "Beatriz", "Daniel"])
      ["Maria I", "Beatriz I", "Carlos I", "Maria II", "Carlos II", "Beatriz II", "Beatriz III", "Daniel I"]

  """

  @roman_numerals %{
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  @doc """
  Main function to execute the CLI tool. Reads names from standard input until an empty line is entered,
  normalizes the names to ensure consistent casing, assigns roman numerals based on the occurrence order,
  and prints the resulting names with their respective numerals.
  """
  @spec main([String.t()]) :: :ok
  def main(_args) do
    formatted_text = IO.ANSI.light_red() <> "Bem-vindo a CLI da Cumbuca!\n" <> IO.ANSI.reset()
    IO.puts(formatted_text)

    IO.puts("Para começar, insira os nomes dos reis 🫅 e rainhas 👸 um por linha.")
    IO.puts("Pressione Enter após cada nome. Quando terminar, deixe uma linha em branco.")
    IO.puts("\nExemplo:\nPedro\nMaria\nDaniel\nEduardo\n")

    IO.puts(
      "A saída será cada nome seguido pelo seu respectivo número romano, indicando a ordem de ocorrência.\n"
    )

    IO.puts("Nomes:")

    read_names()
    |> Enum.map(&normalize_name/1)
    |> assign_roman_numerals_to_names()
    |> Enum.each(&IO.puts/1)
  end

  @doc """
  Normalize a name to capitalize the first letter and lowercase the rest.
  """
  @spec normalize_name(String.t()) :: String.t()
  def normalize_name(name) do
    name
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  @doc """
  Assigns Roman numerals to names based on their occurrence order.
  """
  @spec assign_roman_numerals_to_names([String.t()]) :: [String.t()]
  def assign_roman_numerals_to_names(names) do
    assign_roman_numerals_to_names(names, %{})
  end

  defp assign_roman_numerals_to_names([], _counts) do
    []
  end

  defp assign_roman_numerals_to_names([name | rest], counts) do
    count = Map.get(counts, name, 0) + 1
    updated_counts = Map.put(counts, name, count)
    numbered_name = "#{name} #{to_roman(count)}"
    [numbered_name | assign_roman_numerals_to_names(rest, updated_counts)]
  end

  @doc """
  Convert the number to a roman number.
  """
  def to_roman(number) do
    @roman_numerals
    |> Map.keys()
    |> Enum.sort(:desc)
    |> digits(number, [])
    |> Enum.join()
  end

  defp digits(_, 0, acc), do: acc
  defp digits([head | tail], number, acc) when number < head, do: digits(tail, number, acc)

  defp digits([head | _] = list, number, acc),
    do: digits(list, number - head, acc ++ [@roman_numerals[head]])

  defp read_names do
    read_names([])
  end

  defp read_names(acc) do
    input = String.trim(IO.gets(""))

    if input == "" do
      Enum.reverse(acc)
    else
      read_names([input | acc])
    end
  end
end
