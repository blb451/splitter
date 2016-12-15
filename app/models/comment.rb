class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :music_choice
  has_many :likes, dependent: :destroy, as: :likeable

  validates :user_id, presence: true
  validates :body, presence: true, length: { minimum: 3, maximum: 140 }

end
