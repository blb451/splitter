class FollowingsController < ApplicationController
  before_action :authenticate_user!

    def create
      @following = Following.new find_params
      @following.follower_id = current_user.id
      if @following.save
        redirect_to root_path
      else
        redirect_to root_path
      end
    end

    def destroy
      @following = Following.find params[:id]
      @following.destroy
      redirect_to root_path, notice: 'Unfollowed'
    end


    def find_params
      params.permit(:user_id, :follower_id)
    end

end
