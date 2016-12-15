class ChangeTypeColumnInNewsfeed < ActiveRecord::Migration[5.0]
  def up
    rename_column :newsfeeds, :type, :posttype
  end

  def down
  end
end
