class Newsfeed < ApplicationRecord
    belongs_to :user
    after_create_commit { NewsfeedBroadcastJob.perform_later self }
end
