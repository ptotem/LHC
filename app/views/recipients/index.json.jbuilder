json.array!(@recipients) do |recipient|
  json.extract! recipient, :id, :message_id, :user_id
  json.url recipient_url(recipient, format: :json)
end
