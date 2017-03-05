class ChangeTypeColumnInNewsfeed < ActiveRecord::Migration[5.0]
  def up
    add_column :newsfeeds, :posttype, :string
  end

  def down
  end
end
