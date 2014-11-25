class AddAudioToFeedback < ActiveRecord::Migration
  def self.up
    add_attachment :feedbacks, :audio
  end

  def self.down
    remove_attachment :feedbacks, :audio
  end
end
