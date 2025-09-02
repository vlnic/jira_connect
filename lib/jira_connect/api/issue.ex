defmodule JiraConnect.API.Issue do
  use JiraConnect.API

  action :create_issue,
    endpoint: {:post, "/rest/api/2/issue"},
    params: [
      project_id: :string,
      summary: :string,
      assignee: :string,
      priority: :string,
      issuetype: :string,
      description: {:string, default: nil},
      versions: {:array, :string}, default: [],
      labels: {:array, :string}, default: [],
      update_history: {:boolean, default: true}
    ]
end
