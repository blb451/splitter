class NewsfeedBroadcastJob < ActiveJob::Base
  queue_as :default

  def perform(newsfeed)
    ActionCable.server.broadcast 'newsfeed_channel', newsfeed: render_newsfeed(newsfeed)
  end

  private

  def render_newsfeed(newsfeed)
    ApplicationController.renderer.render(partial: 'newsfeeds/newsfeed', locals: { newsfeed: newsfeed })
  end
end
