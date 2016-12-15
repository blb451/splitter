class ChangeNewsfeedModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :newsfeeds, :first_action
    remove_column :newsfeeds, :second_action
    add_column :newsfeeds, :posttype, :string
  end
end
