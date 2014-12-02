json.array!(@users) do |user|
  json.extract! user, :id, :deviceId, :nickname
  json.url user_url(user, format: :json)
end
