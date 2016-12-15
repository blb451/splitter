class AddColumnToMusicChoice < ActiveRecord::Migration[5.0]
  def change
    add_column :music_choices, :search_id, :string
  end
end
