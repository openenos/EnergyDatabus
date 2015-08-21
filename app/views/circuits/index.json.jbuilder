json.array!(@circuits) do |circuit|
  json.extract! circuit, :id, :active, :input, :breaker_number, :double_breaker, :breaker_size, :display, :elec_load_type_id, :panel_id, :ct_sensor_type, :double_ct, :channel_no
  json.url circuit_url(circuit, format: :json)
end
