class NewsfeedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "newsfeed_channel"
  end

  def unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast "newsfeed_channel", newsfeed: data['newsfeed']
  end
end
