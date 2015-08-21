json.array!(@postal_codes) do |postal_code|
  json.extract! postal_code, :id, :geo_postal_code, :geo_city, :geo_state, :geo_country, :tz, :weather_ref
  json.url postal_code_url(postal_code, format: :json)
end
