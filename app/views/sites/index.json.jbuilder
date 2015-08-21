json.array!(@sites) do |site|
  json.extract! site, :id, :area_gross_square_foot, :site_ref, :display, :year_built, :area_cond_square_foot, :operating_hours, :location_id
  json.url site_url(site, format: :json)
end
