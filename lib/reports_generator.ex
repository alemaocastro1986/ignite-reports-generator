defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options ["foods", "users"]
  def build(filename) do
    filename
    |> Parser.parse_csv()
    |> Enum.reduce(report_acc(), fn row, report -> sum_values(row, report) end)
  end

  def build_from_many(file_names) when not is_list(file_names) or length(file_names) <= 0 do
    {:error, "parameter not enumerable or empty"}
  end

  def build_from_many(file_names) do
    result =
      file_names
      |> Task.async_stream(&build(&1))
      |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)

    {:ok, result}
  end

  def fetch_higher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_k, value} -> value end)}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option"}

  defp sum_reports(%{"foods" => food1, "users" => users1}, %{
         "foods" => foods2,
         "users" => users2
       }) do
    foods = merge_maps(food1, foods2)
    users = merge_maps(users1, users2)
    build_reports(users, foods)
  end

  defp merge_maps(map_a, map_b) do
    Map.merge(map_a, map_b, fn _k, value_a, value_b -> value_a + value_b end)
  end

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods}) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    build_reports(users, foods)
  end

  defp report_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
    build_reports(users, foods)
  end

  defp build_reports(users, foods) do
    %{"users" => users, "foods" => foods}
  end
end
