class ChangeColumnNameForSuggestions < ActiveRecord::Migration[5.0]
  def change
    rename_column :suggestions, :url, :search_id
  end
end
