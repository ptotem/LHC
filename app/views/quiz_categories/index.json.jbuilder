json.array!(@quiz_categories) do |quiz_category|
  json.extract! quiz_category, :id, :name, :intro, :status
  json.url quiz_category_url(quiz_category, format: :json)
end
