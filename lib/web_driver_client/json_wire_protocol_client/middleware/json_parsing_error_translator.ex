defmodule WebDriverClient.JSONWireProtocolClient.Middleware.JSONParsingErrorTranslator do
  @moduledoc false

  alias WebDriverClient.JSONWireProtocolClient.UnexpectedResponseError

  @behaviour Tesla.Middleware

  @impl true
  def call(env, next, _opts) do
    with {:error, {Tesla.Middleware.JSON, :decode, reason}} <- Tesla.run(env, next) do
      {:error, UnexpectedResponseError.exception(reason: reason)}
    end
  end
end