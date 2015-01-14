json.array!(@locations) do |location|
  json.extract! location, :id, :geo_addr, :postal_code_id, :geo_lat, :geo_lng, :utility_id
  json.url location_url(location, format: :json)
end
