class Audio < ActiveRecord::Base
  has_attached_file :audioclip
  validates_attachment_file_name :audioclip, :matches => [/m4a\Z/]

  def audioclip_url
    ActionController::Base.asset_host + self.audioclip.url
  end

  def as_json(options)
    json = super
    json.merge({"audioclip_url" => self.audioclip_url})
  end
end
