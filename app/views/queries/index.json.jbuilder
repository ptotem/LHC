json.array!(@queries) do |query|
  json.extract! query, :id, :name, :email, :subject, :body
  json.url query_url(query, format: :json)
end
