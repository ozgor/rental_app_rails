json.array!(@cities) do |city|
  json.extract! city, :id, :name, :slug
  json.url city_url(city, format: :json)
end
