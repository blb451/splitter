class SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def create
    session.delete(:search_type)
    session.delete(:choice_id)
    @suggestion = Suggestion.new find_params
    @suggestion.user = current_user
    if @suggestion.save
      Newsfeed.create(user: current_user,
                      first_user: current_user.username,
                      first_user_id: current_user.id,
                      first_user_image: current_user.image.mail,
                      first_subject: get_music_name(@suggestion),
                      first_subject_id: @suggestion.id,
                      second_user: @suggestion.music_choice.user.username,
                      second_user_id: @suggestion.music_choice.user.id,
                      second_subject_id: @suggestion.music_choice.id,
                      posttype: 'suggestion')
      send_suggestion_notification
      redirect_to music_choice_path(@suggestion.music_choice)
    else
      redirect_to root_path, alert: @suggestion.errors.full_messages.join('')
    end
  end

  def show
    @suggestion = Suggestion.find params[:id]
    respond_to do |format|
      format.html {render}
      format.js {render}
    end
  end

  def update
    @suggestion = Suggestion.find params[:music_choice_id]
    if !@suggestion.approved?
      approve_suggestion
      Newsfeed.create(user: current_user,
                      first_user: current_user.username,
                      first_user_id: current_user.id,
                      first_user_image: current_user.image.mail,
                      second_user: @suggestion.user.username,
                      second_user_id: @suggestion.user.id,
                      first_subject_id: @suggestion.id,
                      second_subject_id: @suggestion.music_choice.id,
                      posttype: 'approval')
      redirect_to :back
    else
      unapprove_suggestion(@suggestion)
      redirect_to :back
    end
  end

  def destroy
    @suggestion = Suggestion.find params[:music_choice_id]
    @suggestion.destroy
    respond_to do |format|
      if can? :delete, @suggestion
        @suggestion.destroy
        format.js {render}
        format.html { redirect_to @suggestion.music_choice, notice: 'Suggestion deleted!'}
      else
        format.js {render js: 'alert:("Access denied");' }
        format.html { redirect_to :back, alert: 'Access Denied' }
      end
    end
  end

  private

  def find_params
    params.permit(:artist, :album, :track, :apple_link,
     :spotify_link, :youtube_link, :search_id, :music_choice_id, :album_art, :uri)
  end

  def send_suggestion_notification
    (@suggestion.music_choice.user).notify(@suggestion.music_choice.user.username,
    "#{current_user.username} suggested #{get_music_name(@suggestion)}
    for #{get_music_name(@suggestion.music_choice)}", current_user)
  end

  def send_approval_notification
    (@suggestion.user).notify(@suggestion.user.username,
    "#{current_user.username} approved your suggestion of #{get_music_name(@suggestion)}
    for #{get_music_name(@suggestion.music_choice)}", current_user)
  end

  def approve_suggestion
    @suggestion.update_attribute(:approved, true)
    user = @suggestion.user
    user.update_attribute(:reputation, (user.reputation+1))
    @suggestion.save
    user.save
    send_approval_notification
  end

  def unapprove_suggestion(suggestion)
    suggestion.update_attribute(:approved, false)
    user = suggestion.user
    user.update_attribute(:reputation, (user.reputation-1))
    suggestion.save
    user.save
  end

end
