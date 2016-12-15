class CreateStashedMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :stashed_musics do |t|
      t.string :apple_link
      t.string :spotify_link
      t.string :youtube_link
      t.string :search_id
      t.string :music_name

      t.timestamps
    end
  end
end
