class StashedMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music_choice

  validates :music_choice_id, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
end
