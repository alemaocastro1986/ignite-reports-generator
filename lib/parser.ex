defmodule ReportsGenerator.Parser do
  def parse_csv(filename) do
    File.stream!("reports/#{filename}")
    |> Stream.map(&parse_row(&1))
  end

  defp parse_row(row) do
    row
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
