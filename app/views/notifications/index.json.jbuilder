json.array!(@notifications) do |notification|
  json.extract! notification, :id, :content, :user_id, :pointer_link
  json.url notification_url(notification, format: :json)
end
