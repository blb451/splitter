class SearchController < ApplicationController
  before_action :authenticate_user!

  def new
    session[:search_type] = params[:type]
    session[:choice_id] = params[:choice_id]
    respond_to do |format|
      format.html {render}
      format.js {render}
    end
  end

  def index
    respond_to do |format|
      format.html {render}
      format.js { index_params }
    end
  end

  def show
    @music_choice = MusicChoice.new
    @suggestion = Suggestion.new
    respond_to do |format|
      format.html {render}
      format.js { which_show? }
    end
  end

  private

  def index_params
    if !params[:name].empty?
      if params[:search_artist]
        @artists = RSpotify::Artist.search(params[:name])
      end
      if params[:search_album]
        @albums = RSpotify::Album.search(params[:name])
      end
      if params[:search_track]
        @tracks = RSpotify::Track.search(params[:name])
      end
      if !params[:search_artist] && !params[:search_album] && !params[:search_track]
        redirect_to new_search_path, alert: 'You must select an option to search from.'
      end
      else
      redirect_to new_search_path, alert: 'Text field can\'t be blank.'
    end
    render 'index'
  end

  def which_show?
    if params[:track_true]
      @track = RSpotify::Track.find(params[:id])
      @itracks = ITunes.music(@track.name)
      render 'track_show'
    end
    if params[:album_true]
      @album = RSpotify::Album.find(params[:id])
      @ialbums = ITunes.music(@album.name)
      render 'album_show'
    end
    if params[:artist_true]
      @artist = RSpotify::Artist.find(params[:id])
      @iartists = ITunes.music(@artist.name)
      render 'artist_show'
    end
  end

end
