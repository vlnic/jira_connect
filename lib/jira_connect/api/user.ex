defmodule JiraConnect.User do
  use JiraConnect.API

  action :get,
    endpoint: {:get, "/rest/api/2/user"},
    params: [
      username: {:string, default: nil},
      key: {:string, default: nil},
      include_deleted: {:boolean, default: false}
    ]

  action :find,
    endpoint: {:get, "/rest/api/2/user/search"},
    params: [
      username: {:string, default: nil},
      start_at: {:integer, default: 0},
      max_results: {:integer, default: 50},
      include_active: {:boolean, default: true},
      include_inactive: {:boolean, default: false}
    ]
end
