defmodule JiraConnect.HTTP.Finch do
  @behaviour JiraConnect.HTTP

  def request(method, uri, body, headers, opts) do
    method
    |> Finch.build(uri, headers, body, opts)
    |> Finch.request(JiraConnect.finch_name())
    |> parse_response()
  end

  defp parse_response({:ok, %{status: s, body: b, headers: h}}), do: {:ok, s, b, h}
  defp parse_response({:error, %Mint.TransportError{reason: reason}}), do: {:error, reason}
  defp parse_response({:error, %Mint.HTTPError{reason: reason}}), do: {:error, reason}
end
