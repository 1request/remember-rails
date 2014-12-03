class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :creator_id
      t.integer :location_id
      t.string :name
      t.boolean :private

      t.timestamps
    end
  end
end
