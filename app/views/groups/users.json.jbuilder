json.array!(@memberships) do |membership|
  json.extract! membership.user, :id, :nickname, :profile_picture_url, :created_at, :updated_at
  json.status membership.status
end
