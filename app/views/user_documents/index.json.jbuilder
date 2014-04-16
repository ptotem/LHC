json.array!(@user_documents) do |user_document|
  json.extract! user_document, :id, :verification_text
  json.url user_document_url(user_document, format: :json)
end
