class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
