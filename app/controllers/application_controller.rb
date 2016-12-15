class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :mailbox, :conversation

  private

  def get_music_name(object)
    if object.track != nil
      "#{object.artist} - #{object.track}"
    elsif object.track == nil && object.album != nil
      "#{object.artist} - #{object.album}"
    else
      "#{object.artist}"
    end
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,
                                                       :first_name,
                                                       :last_name,
                                                       :image,
                                                       :image_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,
                                                              :first_name,
                                                              :last_name,
                                                              :image,
                                                              :image_cache])
  end
end
