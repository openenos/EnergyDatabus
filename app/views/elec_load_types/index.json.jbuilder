json.array!(@elec_load_types) do |elec_load_type|
  json.extract! elec_load_type, :id, :load_type, :dispaly
  json.url elec_load_type_url(elec_load_type, format: :json)
end
