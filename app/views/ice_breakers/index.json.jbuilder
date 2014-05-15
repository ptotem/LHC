json.array!(@ice_breakers) do |ice_breaker|
  json.extract! ice_breaker, :id
  json.url ice_breaker_url(ice_breaker, format: :json)
end
