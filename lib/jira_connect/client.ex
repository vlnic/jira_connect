defmodule JiraConnect.Client do

  def post(path, body, headers, opts) do
    :post
    |> Finch.build(path, headers, body, opts)
    |> Finch.request(JiraConnect.Finch)
  end
end
