json.array!(@locations) do |location|
  json.extract! location, :id, :longitude, :latitude, :uuid, :major, :minor
  json.url location_url(location, format: :json)
end
