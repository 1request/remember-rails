class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :device_id
      t.string :device_type

      t.timestamps
    end
  end
end
