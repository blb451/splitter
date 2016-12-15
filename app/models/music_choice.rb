class MusicChoice < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :stashed_musics, dependent: :destroy

  validates :user_id, presence: true
  validates :album_art, presence: true
  validates :uri, presence: true

end
