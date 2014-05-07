class ChangeEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :location, :string
    add_column :events, :private, :string, default: 'default'
    add_column :events, :attendees, :text
  end
end
