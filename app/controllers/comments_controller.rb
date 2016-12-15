class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    find_music_choice
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.music_choice = @music_choice
    respond_to do |format|
      if @comment.save
        Newsfeed.create(user: current_user,
                        first_user: current_user.username,
                        first_user_id: current_user.id,
                        first_user_image: current_user.image.mail,
                        first_subject: @comment.body,
                        first_subject_id: @comment.id,
                        second_user: @comment.music_choice.user.username,
                        second_user_id: @comment.music_choice.user.id,
                        second_subject_id: @comment.music_choice.id,
                        posttype: 'comment')
                        send_music_notification
        format.js { render :create_comment_success }
        format.html { redirect_to music_choice_path(@music_choice), notice: 'Comment created!' }
      else
        format.js { render :create_comment_failure }
        format.html { redirect_to music_choice_path(@music_choice), alert: "#{@comment.errors.full_messages.join('')}" }
      end
    end
  end

  def destroy
    find_music_choice
    @comment = Comment.find params[:id]
    respond_to do |format|
      if can? :delete, @comment
        @comment.destroy
        format.js {render}
        format.html { redirect_to @music_choice, notice: 'Comment deleted!'}
      else
        format.js {render js: 'alert:("Access denied");' }
        format.html { redirect_to music_choice_path, alert: 'Access Denied' }
      end
    end
  end

  private

  def send_music_notification
    (@music_choice.user).notify(@music_choice.user.username,
    "#{current_user.username} commented on your post of
    #{get_music_name(@music_choice)}", current_user)
  end

  def find_music_choice
    @music_choice = MusicChoice.find params[:music_choice_id]
  end

end
