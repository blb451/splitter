class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true, index: true
      t.references :follower, foreign_key: {to_table: :users}, index: true
      
      t.timestamps
    end
  end
end
