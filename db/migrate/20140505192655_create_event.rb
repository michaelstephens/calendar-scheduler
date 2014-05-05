class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
