class Audio < ActiveRecord::Base
  has_attached_file :audioclip
  validates_attachment_file_name :audioclip, :matches => [/m4a\Z/]
  belongs_to :group
  belongs_to :user

  def audioclip_url
    self.audioclip.url
  end

  def as_json(options)
    json = super
    json.merge({"audioclip_url" => self.audioclip_url})
  end
end
