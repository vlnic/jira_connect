defmodule JiraConnect.Dashboard do
  use JiraConnect.API

  action :list,
    endpoint: {:get, "/rest/api/2/dashboard"},
    params: [
      filter: {:string, default: nil},
      startAt: {:integer, default: nil},
      maxResults: {:integer, default: nil}
    ]

  action :get,
    endpoint: {:get, "/rest/api/2/dashboard/:id"},
    params: [
      id: :string
    ]

  action :get_item_properties,
    endpoint: {:get, "/rest/api/2/dashboard/:dashboard/items/:item/properties"},
    params: [
      dashboard: :string,
      item: :string
    ]

  action :delete_item_property,
    endpoint: {:delete, "/rest/api/2/dashboard/:dashboard/items/:item/properties/:property"},
    params: [
      dashboard: :string,
      item: :string,
      property: :string
    ]

  action :set_property,
    endpoint: {:put, "/rest/api/2/dashboard/:dashboard/items/:item/properties/:property"},
    params: [
      dashboard: :string,
      item: :string,
      property: :string
    ]

  action :get_property,
    endpoint: {:get, "/rest/api/2/dashboard/:dashboard/items/:item/properties/:property"},
    params: [
      dashboard: :string,
      item: :string,
      property: :string
    ]
end
