json.array!(@site_group_mappings) do |site_group_mapping|
  json.extract! site_group_mapping, :id, :site_group_id, :site_id
  json.url site_group_mapping_url(site_group_mapping, format: :json)
end
