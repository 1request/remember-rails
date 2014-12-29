class User < ActiveRecord::Base
  validates :device_id, presence: true
  validates :device_id, uniqueness: true

  # for profile picture
  has_attached_file :profile_picture, :styles => { :thumb => "100x100>" }
  validates_attachment_file_name :profile_picture, :matches => [/png\Z/, /jpe?g\Z/]

  has_many :created_groups, class_name: "Group", foreign_key: "creator_id"
  has_many :memberships, dependent: :destroy
  has_many :joined_groups, through: :memberships, source: :group

  def profile_picture_url
    ActionController::Base.asset_host + self.profile_picture.url(:thumb)
  end

  def push(group_id)
    APNS.host = Settings.apns_host
    APNS.pem  = Rails.root.join(Settings.apns_path)

    device_token = self.device_token unless self.device_token.nil?

    APNS.send_notification(device_token, :badge => 0,
                                         :other => {:new_audio => {:group_id => group_id}})
  end

  def as_json(options)
    json = super
    json.merge({"profile_picture_url" => self.profile_picture_url})
  end
end
