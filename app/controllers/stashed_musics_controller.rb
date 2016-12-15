class StashedMusicsController < ApplicationController
  before_action :authenticate_user!

  def create
    @music_choice = MusicChoice.find params[:music_choice_id]
    @stashed_music = StashedMusic.new(user: current_user, music_choice: @music_choice)
    respond_to do |format|
      if @stashed_music.save
        format.js { render :stash_reload }
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def index
    @stashed_music = StashedMusic.order(created_at: :desc).page(params[:page]).
                     per(15).where(:user_id => current_user)
  end

  def destroy
    @stashed_music = StashedMusic.find params[:id]
    @music_choice = @stashed_music.music_choice
    respond_to do |format|
      if @stashed_music.destroy
        format.js { render :stash_reload }
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, alert: @stashed_music.errors.full_messages.join(", ") }
      end
    end
  end

end
