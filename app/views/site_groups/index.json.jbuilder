json.array!(@site_groups) do |site_group|
  json.extract! site_group, :id, :display
  json.url site_group_url(site_group, format: :json)
end
