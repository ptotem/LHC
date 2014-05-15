json.array!(@quiz_answers) do |quiz_answer|
  json.extract! quiz_answer, :id, :user_id, :question_id, :answer_id
  json.url quiz_answer_url(quiz_answer, format: :json)
end
