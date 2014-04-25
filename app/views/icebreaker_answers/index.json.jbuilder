json.array!(@icebreaker_answers) do |icebreaker_answer|
  json.extract! icebreaker_answer, :id, :ice_breaker_id, :question_id, :user_id, :answer_id
  json.url icebreaker_answer_url(icebreaker_answer, format: :json)
end
