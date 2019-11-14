defmodule WebDriverClient.Integration.LoggingTest do
  use ExUnit.Case, async: false

  alias WebDriverClient.IntegrationTesting.Scenarios
  alias WebDriverClient.IntegrationTesting.Scenarios.Scenario
  alias WebDriverClient.IntegrationTesting.TestGenerator

  require WebDriverClient.IntegrationTesting.TestGenerator

  @moduletag :capture_log
  @moduletag :integration

  scenarios =
    Scenarios.all()
    |> Enum.filter(fn
      %Scenario{driver: :chromedriver, protocol: :w3c} ->
        # Chromedriver does not allow for jwp endpoints in w3c mode
        false

      %Scenario{driver: :selenium_3, browser: :firefox, protocol: :jwp} ->
        # This scenario returns a 500 error
        false

      _ ->
        true
    end)

  TestGenerator.generate_describe_per_scenario scenarios: scenarios do
    test "retrieving log types", %{scenario: scenario} do
      config = Scenarios.get_config(scenario)
      payload = Scenarios.get_start_session_payload(scenario)

      {:ok, session} = WebDriverClient.start_session(payload, config: config)

      {:ok, log_types} = WebDriverClient.fetch_log_types(session)
      assert Enum.all?(log_types, &is_binary/1)
    end
  end
end
