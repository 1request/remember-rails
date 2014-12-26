json.array!(@memberships) do |membership|
  json.extract! membership.group, :id, :name, :private, :created_at, :updated_at
  json.location membership.group.location
  json.creator membership.group.creator
  json.creator_profile_url membership.group.creator.profile_picture_url
  json.status membership.status
end
