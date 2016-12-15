class AddReferenceToStashedMusic < ActiveRecord::Migration[5.0]
  def change
    add_reference :stashed_musics, :user, foreign_key: true
  end
end
