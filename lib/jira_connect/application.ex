defmodule JiraConnect.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: JiraConnect.finch_name()}
    ]

    opts = [strategy: :one_for_one, name: JiraConnect.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
