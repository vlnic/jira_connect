defmodule JiraConnect.Status do
  use JiraConnect.API

  action :all,
    endpoint: {:get, "/rest/api/2/status"}

  action :get,
    endpoint: {:get, "/rest/api/2/status/:status"},
    params: [
      status: {:primitive, :string}
    ]
end
