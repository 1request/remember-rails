class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :longitude
      t.float :latitude
      t.string :uuid
      t.integer :major
      t.integer :minor

      t.timestamps
    end
  end
end
