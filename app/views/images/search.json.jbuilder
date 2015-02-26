json.array!(@images) do |image|
  json.extract! image, :id, :link, :text, :rating, :created_at, :updated_at
  json.url image_url(image, format: :json)
end

