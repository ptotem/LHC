json.array!(@criterions) do |criterion|
  json.extract! criterion, :id
  json.url criterion_url(criterion, format: :json)
end
