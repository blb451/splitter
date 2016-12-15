module ApplicationHelper

  def header(text)
    content_for(:header) { text.to_s }
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

  def display_image_mail(user)
    if user&.image.nil?
      image_tag(image_path('fallback/mail_default.jpg'))
    else
      image_tag(user.image.mail)
    end
  end

  def display_image_newsfeed(user)
    if user.first_user_image.nil?
      image_tag(image_path('fallback/mail_default.jpg'))
    else
      image_tag(user.first_user_image)
    end
  end

  def display_image(user)
    if user&.image.nil?
      image_tag(image_path('fallback/default'))
    else
      image_tag(user.image.small)
    end
  end

  def get_music_name(object)
    if object.track != nil
      "#{object.artist} - #{object.track}"
    elsif object.track == nil && object.album != nil
      "#{object.artist} - #{object.album}"
    else
      "#{object.artist}"
    end
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
