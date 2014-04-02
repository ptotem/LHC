json.array!(@answers) do |answer|
  json.extract! answer, :id, :name
  json.url answer_url(answer, format: :json)
end
