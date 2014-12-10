class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :location
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def as_json(options)
    json = super

    to_merge = {
      "location" => self.location,
      "creator_profile_url" => self.creator.profile_picture_url
    }

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
