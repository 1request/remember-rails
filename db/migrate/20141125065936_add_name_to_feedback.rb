class AddNameToFeedback < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :name, :string
  end

  def self.down
    remove_column :feedbacks, :name
  end
end
