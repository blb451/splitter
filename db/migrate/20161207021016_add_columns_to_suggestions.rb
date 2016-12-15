class AddColumnsToSuggestions < ActiveRecord::Migration[5.0]
  def change
    add_column :suggestions, :apple_link, :string
    add_column :suggestions, :spotify_link, :string
    add_column :suggestions, :youtube_link, :string
  end
end
