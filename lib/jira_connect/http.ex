defmodule JiraConnect.HTTP do
  @type method :: atom()
  @type uri :: binary() | URI.t()
  @type body :: binary() | map() | tuple()
  @type headers :: list()
  @type opts :: Keyword.t()
  @type status :: non_neg_integer()
  @type reason :: term()

  @callback request(method, uri, body, headers, opts) :: {:ok, status, body, headers} | {:error, reason}

  @impl Application.compile_env(:jira_connect, :http_impl, JiraConnect.HTTP.Finch)

  defmodule State do
    defstruct [
      :method, :uri, :path, :req_headers, :req_body,
      :opts, :client_opts, :transport_opts, :params,
      :resp_body, :resp_headers, :status,
      :error
    ]
  end

  def request(method, path, params, opts) do
    %State{
      method: method,
      path: path,
      params: filter_params(params),
      opts: opts
    }
    |> prepare_path()
    |> build_request_uri()
    |> build_request_headers()
    |> build_request_body()
    |> process_request()
  end

  defp process_request(%{
    method: method,
    uri: uri,
    req_body: body,
    headers: headers,
    transport_opts: opts
  } = state) do
    case @impl.request(method, uri, body, headers, opts) do
      {:ok, status, body, headers} ->
        %{state | status: status, resp_body: body, resp_headers: headers}

      {:error, reason} ->
        %{state | error: reason}
    end
  end

  defp build_request_headers(%State{} = state) do
    headers = [state.req_headers | {"Authorization", "Bearer #{JiraConnect.auth_token()}"}]
    %{state | req_headers: List.flatten(headers)}
  end

  defp build_request_body(%{method: method} = state) when method in [:get, :delete, :header] do
    %{state | req_body: ""}
  end

  defp build_request_body(%State{} = state) do
    if is_struct(state.params) do
      json =
        state.params
        |> Map.from_struct()
        |> Jason.encode!()

      %{state | req_body: json}
    else
      %{state | req_body: Jason.encode!(state.params)}
    end
  end

  defp build_request_uri(%State{method: method} = state) when method in [:get, :delete] do
    {_, path} =
      state.params
      |> Map.to_list()
      |> Enum.reduce({0, state.path}, fn({k, v}, {index, acc}) ->
        case index do
          0 ->
            {1, "#{acc}?#{k}=#{v}"}

          _ ->
            {1, "#{acc}&#{k}=#{v}"}
        end
      end)

    %{state | uri: prepare_uri(path)}
  end

  defp build_request_uri(%State{path: path} = state) do
    %{state | uri: prepare_uri(path)}
  end

  defp prepare_uri(path) do
    JiraConnect.host()
    |> Path.join(path)
    |> URI.parse()
  end

  # put path params like /service/:context/:resource_id
  defp prepare_path(%State{params: params, path: path} = state) do
    case get_path_keys(path) do
      [] ->
        state

      keys ->
        {path, params} = put_path_params(params, keys, path)
        %{state | path: path, params: params}
    end
  end

  defp put_path_params(source_params, keys, source_path) do
    {path, params} =
      Enum.reduce(keys, {source_path, source_params}, fn(key, {path, params}) ->
        {value, params} = Map.pop(params, String.to_existing_atom(key), "")
        {String.replace(path, ":#{key}", value), params}
      end)

    {String.trim_trailing(path, "/"), params}
  end

  defp get_path_keys(path) do
    ~r/\/\:\w+/
    |> Regex.scan(path)
    |> Enum.take(2)
    |> List.flatten()
    |> Enum.map(fn(k) -> String.replace(k, "/:", "") end)
  end

  defp filter_params(params) when is_struct(params) do
    Map.from_struct(params) |> filter_params()
  end
  defp filter_params(params) do
    for {_k, v} = p <- params, v != nil, into: %{}, do: p
  end
end
