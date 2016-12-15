class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def like_for(user)
    likes.find_by(user: user)
  end

  def stashed_for(user)
    stashed_musics.find_by(user: user)
  end


end
