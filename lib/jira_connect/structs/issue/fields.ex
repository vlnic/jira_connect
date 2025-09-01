defmodule JiraConnect.Structs.Issue.Fields do
  use Construct

  structure do
    field :title, :string
    field :project, :string
  end
end
