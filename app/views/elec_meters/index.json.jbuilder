json.array!(@elec_meters) do |elec_meter|
  json.extract! elec_meter, :id, :meter_type, :meter_main, :display, :site_id, :meter_loc, :phase, :amp, :volt
  json.url elec_meter_url(elec_meter, format: :json)
end
