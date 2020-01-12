defmodule WebDriverClient.W3CWireProtocolClient.Commands.FetchCurrentURL do
  @moduledoc false

  alias WebDriverClient.Config
  alias WebDriverClient.HTTPClientError
  alias WebDriverClient.HTTPResponse
  alias WebDriverClient.Session
  alias WebDriverClient.W3CWireProtocolClient
  alias WebDriverClient.W3CWireProtocolClient.ResponseParser
  alias WebDriverClient.W3CWireProtocolClient.TeslaClientBuilder
  alias WebDriverClient.W3CWireProtocolClient.UnexpectedResponseError
  alias WebDriverClient.W3CWireProtocolClient.WebDriverError

  @type url :: W3CWireProtocolClient.url()

  @spec send_request(Session.t()) :: {:ok, HTTPResponse.t()} | {:error, HTTPClientError.t()}
  def send_request(%Session{id: id, config: %Config{} = config}) do
    client = TeslaClientBuilder.build_simple(config)
    url = "/session/#{id}/url"

    case Tesla.get(client, url) do
      {:ok, env} ->
        {:ok, HTTPResponse.build(env)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec parse_response(HTTPResponse.t()) ::
          {:ok, url} | {:error, UnexpectedResponseError.t() | WebDriverError.t()}
  def parse_response(%HTTPResponse{} = http_response) do
    with {:ok, w3c_response} <- ResponseParser.parse_response(http_response),
         :ok <- ResponseParser.ensure_successful_response(w3c_response),
         {:ok, url} <- ResponseParser.parse_url(w3c_response) do
      {:ok, url}
    end
  end
end
