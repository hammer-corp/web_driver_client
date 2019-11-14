defmodule WebDriverClient.JSONWireProtocolClient.TestResponses do
  @moduledoc false
  use ExUnitProperties

  def fetch_window_size_response do
    window_size_response() |> map(&Jason.encode!/1)
  end

  def set_window_size_response do
    blank_value_response() |> map(&Jason.encode!/1)
  end

  def fetch_current_url_response do
    fixed_map(%{"value" => url()}) |> map(&Jason.encode!/1)
  end

  def fetch_log_types_response do
    %{"value" => list_of(string(:alphanumeric), max_length: 10)}
    |> fixed_map()
    |> map(&Jason.encode!/1)
  end

  defp blank_value_response do
    constant(%{"value" => nil})
  end

  defp window_size_response do
    fixed_map(%{
      "value" =>
        fixed_map(%{
          "width" => integer(0..1000),
          "height" => integer(0..1000)
        })
    })
  end

  defp url do
    constant("http://example.com")
  end
end
