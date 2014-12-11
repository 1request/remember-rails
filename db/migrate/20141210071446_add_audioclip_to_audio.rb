class AddAudioclipToAudio < ActiveRecord::Migration
  def self.up
    add_attachment :audios, :audioclip
  end

  def self.down
    remove_attachment :audios, :audioclip
  end
end
