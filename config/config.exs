import Config

config :jira_connect,
  connect_pool: 10,
  timeout: 60_000,
  host: System.get_env("JIRA_HOST"),
  api_token: System.get_env("JIRA_API_TOKEN")
