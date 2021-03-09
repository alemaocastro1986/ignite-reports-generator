defmodule ReportsGeneratorTest do
  use ExUnit.Case
  alias ReportsGenerator

  @file_name "report_test.csv"

  describe "build/1" do
    test "must return the sum of purchases per user and the count of occurrence of foods" do
      sut = ReportsGenerator.build(@file_name)

      expected = %{
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        },
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        }
      }

      assert sut == expected
    end
  end

  describe "build_for_many/1" do
    test "when a file list is provided, builds the report" do
      sut = ReportsGenerator.build_from_many([@file_name, @file_name])

      expected =
        {:ok,
         %{
           "users" => %{
             "1" => 96,
             "10" => 72,
             "11" => 0,
             "12" => 0,
             "13" => 0,
             "14" => 0,
             "15" => 0,
             "16" => 0,
             "17" => 0,
             "18" => 0,
             "19" => 0,
             "2" => 90,
             "20" => 0,
             "21" => 0,
             "22" => 0,
             "23" => 0,
             "24" => 0,
             "25" => 0,
             "26" => 0,
             "27" => 0,
             "28" => 0,
             "29" => 0,
             "3" => 62,
             "30" => 0,
             "4" => 84,
             "5" => 98,
             "6" => 36,
             "7" => 54,
             "8" => 50,
             "9" => 48
           },
           "foods" => %{
             "açaí" => 2,
             "churrasco" => 4,
             "esfirra" => 6,
             "hambúrguer" => 4,
             "pastel" => 0,
             "pizza" => 4,
             "prato_feito" => 0,
             "sushi" => 0
           }
         }}

      assert sut == expected
    end

    test "when a file list not is provided, return an error" do
      sut = ReportsGenerator.build_from_many([])

      expected = {:error, "parameter not enumerable or empty"}
      assert sut == expected
    end
  end

  describe "fetch_higher_cost/2" do
    test "should return user with higher spend" do
      sut =
        ReportsGenerator.build(@file_name)
        |> ReportsGenerator.fetch_higher_cost("users")

      expected = {:ok, {"5", 49}}

      assert sut == expected
    end

    test "should return the food more frequently" do
      sut =
        ReportsGenerator.build(@file_name)
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected = {:ok, {"esfirra", 3}}

      assert sut == expected
    end

    test "should return an error when the option is invalid" do
      sut =
        ReportsGenerator.build(@file_name)
        |> ReportsGenerator.fetch_higher_cost("no-option")

      expected = {:error, "Invalid option"}

      assert sut == expected
    end
  end
end
