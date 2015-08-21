json.array!(@accounts) do |account|
  json.extract! account, :id, :company_name, :company_reference
  json.url account_url(account, format: :json)
end
