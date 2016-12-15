class AddColumnsToMusicChoice < ActiveRecord::Migration[5.0]
  def change
    add_column :music_choices, :apple_link, :string
    add_column :music_choices, :spotify_link, :string
    add_column :music_choices, :youtube_link, :string
  end
end
