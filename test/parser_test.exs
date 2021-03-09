defmodule ReportsGenerator.ParserTest do
  use ExUnit.Case

  alias ReportsGenerator.Parser

  @file_name "report_test.csv"

  describe "parse_csv/1" do
    test "should return a parsed file" do
      sut =
        @file_name
        |> Parser.parse_csv()
        |> Enum.map(& &1)

      expected = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      assert sut == expected
    end
  end
end
