class MusicChoicesController < ApplicationController
  before_action :authenticate_user!

  def create
    session.delete(:search_type)
    @music_choice = MusicChoice.new find_params
    @music_choice.user = current_user
    get_music_name
    if @music_choice.save
      Newsfeed.create(user: current_user,
                      first_user: current_user.username,
                      first_user_id: current_user.id,
                      first_user_image: current_user.image.mail,
                      first_subject: @music_name,
                      first_subject_id: @music_choice.id,
                      posttype: 'music_choice')
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def index
    @top_users = User.where(!MusicChoice.where("music_choices.user_id = users.id").exists.not).
    order(reputation: :desc)
  end

  def show
    session.delete(:search_type)
    find_music_choice
    @music_suggestions = @music_choice.suggestions.sort_by {|record| record.created_at}.reverse!
    @music_comments = @music_choice.comments.sort_by {|record| record.created_at}
    @music_choice_like = @music_choice.like_for(current_user)
    @comment ||= Comment.new
  end

  def destroy
    find_music_choice
    @music_choice.destroy
    redirect_to root_path
  end

  private

  def find_music_choice
    @music_choice ||= MusicChoice.find params[:id]
  end

  def find_params
    params.permit(:artist, :album, :track, :uri, :album_art, :apple_link,
     :spotify_link, :youtube_link, :search_id, :search_artist, :search_album,
     :search_track)
  end

  def get_music_name
    if @music_choice.track != nil
      @music_name = "#{@music_choice.artist} - #{@music_choice.track}"
    elsif @music_choice.track == nil && @music_choice.album != nil
      @music_name = "#{@music_choice.artist} - #{@music_choice.album}"
    else
      @music_name = "#{@music_choice.artist}"
    end
  end

end
