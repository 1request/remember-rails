class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :location
  has_many :memberships
  has_many :members, through: :memberships

  def as_json(options)
    json = super

    location = Location.find(self.location_id)
    json.merge({"location" => location})
  end
end
