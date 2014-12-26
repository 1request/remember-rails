class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :location
  reverse_geocoded_by "locations.latitude", "locations.longitude"
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  def as_json(options)
    json = super

    creator_profile_url = if self.creator
      self.creator.profile_picture_url
    else
      ActionController::Base.asset_host + "/profile_pictures/thumb/missing.png"
    end

    to_merge = {
      "location" => self.location,
      "creator_profile_url" => creator_profile_url
    }

    if options[:list_users]
      accepted_members = Array.new
      self.memberships.where(status: "accepted").each do |membership|
        accepted_members << membership.user
      end
      to_merge[:accepted_members] = accepted_members

      applying_members = Array.new
      self.memberships.where(status: "applying").each do |membership|
        applying_members << membership.user
      end
      to_merge[:applying_members] = applying_members
    end

    if options[:params]
      params = options[:params]

      if params[:user_id]
        membership = self.memberships.where(user_id: params[:user_id])
        status = membership.first.status unless membership.empty?
        to_merge[:status] = status
      end
    end

    json.merge(to_merge)
  end
end
