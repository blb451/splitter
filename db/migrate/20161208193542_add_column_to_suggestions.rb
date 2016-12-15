class AddColumnToSuggestions < ActiveRecord::Migration[5.0]
  def change
    add_column :suggestions, :album_art, :string
    add_column :suggestions, :uri, :string
  end
end
