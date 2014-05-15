json.array!(@quests) do |quest|
  json.extract! quest, :id, :name
  json.url quest_url(quest, format: :json)
end
