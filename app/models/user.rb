class User < ActiveRecord::Base
  validates :device_id, presence: true
  validates :device_id, uniqueness: true

  # for profile picture
  has_attached_file :profile_picture
  validates_attachment_file_name :profile_picture, :matches => [/png\Z/, /jpe?g\Z/]

  has_many :group
end
