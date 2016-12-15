class DropColumnsFromStashedMusic < ActiveRecord::Migration[5.0]
  def change
    remove_column :stashed_musics, :apple_link
    remove_column :stashed_musics, :spotify_link
    remove_column :stashed_musics, :youtube_link
    remove_column :stashed_musics, :search_id
    remove_column :stashed_musics, :music_name
  end
end
