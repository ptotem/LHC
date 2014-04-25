json.array!(@demographics) do |demographic|
  json.extract! demographic, :id
  json.url demographic_url(demographic, format: :json)
end
