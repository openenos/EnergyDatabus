json.array!(@panels) do |panel|
  json.extract! panel, :id, :emon_url, :equip_ref, :panel_type, :parent_panel_id, :site_id, :no_of_circuits, :amp
  json.url panel_url(panel, format: :json)
end
