json.array!(@draws) do |draw|
  json.extract! draw, :id, :postIt_id, :content
  json.url draw_url(draw, format: :json)
end
