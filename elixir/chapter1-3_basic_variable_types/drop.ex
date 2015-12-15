defmodule Drop0 do
#default value of arguments
  def fall_velocity(distance, gravity \\ 9.8) do
    :math.sqrt(2 * gravity * distance)
  end

  def mps_to_mph(mps) do
    2.23693629 * mps
  end

  def mps_to_kph(mps) do
    3.6 * mps
  end
end

defmodule Drop1 do
#pattern-match
  def fall_velocity(:earth, distance) do
    :math.sqrt(2 * 9.8 * distance)
  end

  def fall_velocity(:moon, distance) do
    :math.sqrt(2 * 1.6 * distance)
  end

  def fall_velocity(:mars, distance) do
    :math.sqrt(2 * 3.71 * distance)
  end
end

#guards
defmodule Drop2 do
  def fall_velocity(:earth, distance) when distance >= 0 do
    :math.sqrt(2 * 9.8 * distance)
  end
  def fall_velocity(:moon, distance) when distance >= 0 do
    :math.sqrt(2 * 1.6 * distance)
  end
  def fall_velocity(:mars, distance) when distance >= 0 do
    :math.sqrt(2 * 3.71 * distance)
  end
end

#pass a tuple as the only argument, do the math in the private methods
defmodule Drop3 do
  def fall_velocity({planemo, distance}) when distance >= 0 do
    fall_velocity(planemo, distance)
  end
  defp fall_velocity(:earth, distance) do
    :math.sqrt(2 * 9.8 * distance)
  end
  defp fall_velocity(:moon, distance) do
    :math.sqrt(2 * 1.6 * distance)
  end
  defp fall_velocity(:mars, distance) do
    :math.sqrt(2 * 3.71 * distance)
  end
end