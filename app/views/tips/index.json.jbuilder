json.array!(@tips) do |tip|
  json.extract! tip, :id, :postIt_id, :content
  json.url tip_url(tip, format: :json)
end
