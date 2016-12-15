class HomeController < ApplicationController

  def index
    if user_signed_in?
      @music_choices = (MusicChoice.order(created_at: :desc).
                        page(params[:page]).
                        where(:user_id => current_user.followed_users)
                        .or(MusicChoice.order(created_at: :desc).
                        page(params[:page]).where(:user_id => current_user))).
                        page(params[:page]).per(8)
      @combined_news = (Newsfeed.order(created_at: :desc).
                        page(params[:page]).
                        where(:user_id => current_user.followed_users)
                       .or(Newsfeed.order(created_at: :desc).
                        page(params[:page]).where(:user_id => current_user))).
                        page(params[:page]).per(21)
    end
    respond_to do |format|
      format.html {render}
      format.js {render 'music_choices'}
    end
  end

  def show
    @music_choice ||= MusicChoice.find params[:id]
    @comment ||= Comment.new
    @combined = (@music_choice.suggestions + @music_choice.comments).
                sort_by {|record| record.created_at}.reverse!
  end

end
