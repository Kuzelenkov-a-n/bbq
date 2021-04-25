module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
