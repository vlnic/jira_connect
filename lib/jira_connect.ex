defmodule JiraConnect do

  def finch_name, do: JiraConnect.Finch

  def host, do: Application.get_env(:jira_connect, :host)

  def auth_token, do: Application.get_env(:jira_connect, :api_token)
end
