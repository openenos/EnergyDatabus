json.array!(@people) do |person|
  json.extract! person, :id, :full_name, :phone
  json.url person_url(person, format: :json)
end
