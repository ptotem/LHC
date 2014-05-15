json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :test_id, :name
  json.url quiz_url(quiz, format: :json)
end
