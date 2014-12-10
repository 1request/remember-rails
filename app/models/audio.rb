class Audio < ActiveRecord::Base
  has_attached_file :audioclip
  validates_attachment_file_name :audioclip, :matches => [/m4a\Z/]
end
