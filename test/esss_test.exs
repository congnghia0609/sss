defmodule ESSSTest do
  use ExUnit.Case
  # doctest ESSS

  test "Gen random number" do
    n = ESSS.random_number()
    # IO.puts(n)
    assert 0 < n
    assert n < ESSS.get_prime()
  end

  test "Get modinv" do
    x = ESSS.modinv(2, 7)
    # IO.puts(x)
    assert x == 4
  end

  test "Get hex string of integer" do
    hex = ESSS.to_hex(255)
    # IO.puts(hex)
    assert hex == "00000000000000000000000000000000000000000000000000000000000000FF"
    assert String.length(hex) == 64
  end

  test "Get integer from hex string" do
    i = ESSS.from_hex("00000000000000000000000000000000000000000000000000000000000000FF")
    # IO.puts(i)
    assert i == 255
  end

  test "Gen list random" do
    n = 10
    list = ESSS.UniqueList.generate(n, MapSet.new())
    # IO.inspect(list)
    assert length(list) == n

    c = 3
    for i <- 1..c do
      if i == c do
        sub_list = Enum.slice(list, 0, c)
        # IO.inspect(sub_list)
        assert length(sub_list) == c
        list = Enum.slice(list, c, n - c)
        # IO.inspect(list)
        assert length(list) == n - c
      end
    end
    # IO.puts("---------")
    # IO.inspect(list)
    assert length(list) == n
    # for x <- 1..2, y <- 1..3, z <- 1..4 do
    #   IO.puts("x=#{x}, y=#{y}, z=#{z}")
    # end
  end

  # test "Test map" do
  #   ms = MapSet.new()
  #   for i <- 1..3 do
  #     MapSet.put(ms, i)
  #     IO.puts("for ms length = #{MapSet.size(ms)}")
  #   end
  #   IO.puts("ms length = #{MapSet.size(ms)}")
  # end

  test "Test matrix 2d" do
    value = 9
    x = 2
    y = 3
    zero_matrix = ESSS.gen_zero_matrix_2d(x, y)
    # IO.inspect(zero_matrix) # [[0, 0, 0], [0, 0, 0]]
    zero_matrix = ESSS.update_matrix_2d(zero_matrix, 0, 1, value)
    # IO.inspect(zero_matrix) # [[0, 9, 0], [0, 0, 0]]
    v = ESSS.get_matrix_2d(zero_matrix, 0, 1)
    # IO.puts(v) # 9
    assert v == value
  end
end
