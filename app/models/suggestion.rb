class Suggestion < ApplicationRecord

  class UniqueSuggestionValidator < ActiveModel::Validator
    def validate(record)
      if Suggestion.where(
        music_choice_id: record.music_choice_id,
         artist: record.artist , track: record.track, album: record.album).exists?
        record.errors[:all].push << "This suggestion already exists!"
      end
    end
  end

  def is_not_suggestion_inception
    if track == music_choice.track && artist == music_choice.artist && album == music_choice.album
    errors.add(:music_choice_id, " and suggestion can't be the same")
    end
  end

  belongs_to :user
  belongs_to :music_choice
  has_many :likes, dependent: :destroy, as: :likeable

  validates :music_choice_id, presence: true
  validates :user_id, presence: true
  validate :is_not_suggestion_inception

  validates_with UniqueSuggestionValidator

end
