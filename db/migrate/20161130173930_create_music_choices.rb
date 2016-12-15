class CreateMusicChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :music_choices do |t|
      t.string :artist
      t.string :album
      t.string :track
      t.string :album_art
      t.string :uri
      t.references :user, foreign_key: true, index:true

      t.timestamps
    end
  end
end
