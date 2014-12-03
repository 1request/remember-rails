class AddDeviceTokenToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :deviceId
    add_column :users, :device_id, :string
    add_column :users, :device_token, :string
    add_column :users, :device_type, :string
  end

  def self.down
    add_column :users, :deviceId, :string
    remove_column :users, :device_id
    remove_column :users, :device_token
    remove_column :users, :device_type
  end
end
