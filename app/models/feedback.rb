class Feedback < ActiveRecord::Base
  # for audio
  has_attached_file :audio
  validates_attachment_file_name :audio, :matches => [/m4a\Z/]
end
