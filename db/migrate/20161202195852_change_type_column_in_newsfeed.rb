class ChangeTypeColumnInNewsfeed < ActiveRecord::Migration[5.0]
  def up
    add_column :newsfeeds, :posttype
  end

  def down
  end
end
