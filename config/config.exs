import Config

config :jira_connect,
  connect_pool: 10,
  timeout: 60_000,
  instance_uri: System.get_env("JIRA_INSTANCE_URI"),
  auth_data: System.get_env("JIRA_API_TOKEN")
