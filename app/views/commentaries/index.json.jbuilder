json.array!(@commentaries) do |commentary|
  json.extract! commentary, :id, :user_id, :article_id, :content
  json.url commentary_url(commentary, format: :json)
end
