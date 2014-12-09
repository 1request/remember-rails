class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :location
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def as_json(options)
    json = super

    json.merge({
      "location" => self.location,
      "creator_profile_url" => self.creator.profile_picture_url
    })
  end
end
