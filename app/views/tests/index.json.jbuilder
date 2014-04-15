json.array!(@tests) do |test|
  json.extract! test, :id, :name, :status
  json.url test_url(test, format: :json)
end
