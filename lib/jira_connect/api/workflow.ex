defmodule JiraConnect.Workflow do
  use JiraConnect.API

  action :all,
    endpoint: {:get, "/rest/api/2/workflow"},
    params: [
      workflow_name: :string
    ]

  action :get_properties,
    endpoint: {:get, "/rest/api/2/workflow/:id/properties"},
    params: [
      id: :string,
      key: {:string, default: nil},
      workflow_name: {:string, default: nil},
      workflow_mode: {:string, default: nil},
      include_reversed_keys: {:boolean, default: nil}
    ]
end
