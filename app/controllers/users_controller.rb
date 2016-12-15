class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @following = Following.new
    @users = User.search(params[:search]).order(created_at: :desc)
  end

  def show
    find_user
    top_marks(@user)
    @following = Following.new
    @music_choices = MusicChoice.order(created_at: :desc).page(params[:page]).
                                 where(:user_id => @user.id).per(9)
  end

  private

  def find_user
    @user ||= User.find params[:id]
  end

  def top_marks(user)
    if user.music_choices.count > 0
      @top_artist = user.music_choices.group(:artist).order('count_id DESC').count(:id).first[0]
    else
      @top_artist = 'n/a'
    end
    if user.suggestions.count > 0
      @top_suggestion = user.suggestions.group([:artist, :album, :track]).
                        order('count_id DESC').count(:id).first[0].join(', ')
    else
      @top_suggestion = 'n/a'
    end
  end

end
