class ChangePrivateToVisibility < ActiveRecord::Migration
  def change
    rename_column :events, :private, :visibility
  end
end
