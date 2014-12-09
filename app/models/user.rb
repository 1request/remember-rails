class User < ActiveRecord::Base
  validates :device_id, presence: true
  validates :device_id, uniqueness: true

  # for profile picture
  has_attached_file :profile_picture, :styles => { :thumb => "100x100>" }
  validates_attachment_file_name :profile_picture, :matches => [/png\Z/, /jpe?g\Z/]

  has_many :created_groups, class_name: "Group", foreign_key: "creator_id" 
  has_many :memberships
  has_many :joined_groups, through: :memberships, source: :user

  def profile_picture_url
    ActionController::Base.asset_host + self.profile_picture.url(:thumb)
  end

  def as_json(options)
    json = super
    json.merge({"profile_picture_url" => self.profile_picture_url})
  end
end
