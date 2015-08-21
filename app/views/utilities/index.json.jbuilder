json.array!(@utilities) do |utility|
  json.extract! utility, :id, :display, :utility_type, :base_rate, :demand, :tier1_rate, :tier2_rate, :tier3_rate
  json.url utility_url(utility, format: :json)
end
