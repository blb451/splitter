class AddFirstUserImageColumnToNewsfeed < ActiveRecord::Migration[5.0]
  def change
    add_column :newsfeeds, :first_user_image, :string
  end
end
