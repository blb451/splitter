class AddMusicChoiceReferenceToStashedMusic < ActiveRecord::Migration[5.0]
  def change
    add_reference :stashed_musics, :music_choice, foreign_key: true
  end
end
