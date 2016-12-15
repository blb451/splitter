class CreateNewsfeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :newsfeeds do |t|
      t.string :first_user
      t.string :first_user_id
      t.string :first_action
      t.string :first_subject
      t.string :first_subject_id
      t.string :second_user
      t.string :second_user_id
      t.string :second_action
      t.string :second_subject
      t.string :second_subject_id
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
