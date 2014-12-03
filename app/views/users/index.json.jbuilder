json.array!(@users) do |user|
  json.extract! user, :id, :device_id, :device_token, :device_type, :nickname
  json.url user_url(user, format: :json)
end
