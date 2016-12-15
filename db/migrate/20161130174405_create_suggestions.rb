class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.references :user, foreign_key: true, index: true
      t.references :music_choice, foreign_key: true, index: true
      t.string :artist
      t.string :album
      t.string :track
      t.string :url
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
