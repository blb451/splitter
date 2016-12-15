class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likeable = find_likeable
    like = @likeable.likes.build params.permit(:body, :user, :likeable_id)
    like.user = current_user
    respond_to do |format|
      if like.save
        Newsfeed.create(user: current_user,
                        first_user: current_user.username,
                        first_user_id: current_user.id,
                        first_user_image: current_user.image.mail,
                        first_subject: liketype,
                        first_subject_id: @likeable.id,
                        second_user: @likeable.user.username,
                        second_user_id: @likeable.user.id,
                        second_subject_id: likeable_music,
                        posttype: 'like')
        send_like_notification
        format.js { render 'music_choices/like_reload' }
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @likeable = find_likeable
    like = Like.find params[:id]
    respond_to do |format|
      if like.destroy
        format.js { render 'music_choices/like_reload' }
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, alert: like.errors.full_messages.join(", ") }
      end
    end
  end

  private

  def find_likeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def likeable_music
    if @likeable.class == MusicChoice
       @likeable.id
    else
      @likeable.music_choice.id
    end
  end

  def send_like_notification
    case liketype
      when 'suggestion'
        (@likeable.user).notify(@likeable.user.username,
        "#{current_user.username} liked your suggestion of
        #{get_music_name(@likeable.music_choice)}", current_user)
      when 'comment'
        (@likeable.user).notify(@likeable.user.username,
        "#{current_user.username} liked your comment on the post
        #{get_music_name(@likeable.music_choice)}", current_user)
      when 'post'
        (@likeable.user).notify(@likeable.user.username,
        "#{current_user.username} liked that you're listening to
        #{get_music_name(@likeable)}", current_user)
    end
  end

  def liketype
    @like_type = @likeable.class.to_s.downcase
    if @like_type == 'musicchoice'
      'post'
    else
      @like_type
    end
  end

end
