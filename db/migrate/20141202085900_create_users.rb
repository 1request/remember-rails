class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :deviceId
      t.string :nickname

      t.timestamps
    end
  end
end
