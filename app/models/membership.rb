class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  def push
    APNS.host = Settings.apns_host
    APNS.pem  = Rails.root.join(Settings.apns_path)

    device_token = self.group.creator.device_token unless self.group.creator.device_token.nil?

    APNS.send_notification(device_token, :alert => "#{self.user.nickname} wants to join #{self.group.name}" , :badge => 1, :sound => 'default',
                                         :other => {:approve_member => {:membership_id => self.id}})
  end
end
