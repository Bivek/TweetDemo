module ApplicationHelper
  def get_thumb_profile_pic(user)
    if user.avatar.present?
      image_tag(user.avatar.url(:thumb))
    else
      image_tag('default_thumb.png')
    end
  end

  def get_medium_profile_pic(user)
    if user.avatar.present?
      image_tag(user.avatar.url(:medium))
    else
      image_tag('default_medium.png')
    end
  end

  def get_large_profile_pic(user)
   if user.avatar.present?
      image_tag(user.avatar.url(:large))
    else
      image_tag('default_large.png')
    end
  end
  
end
