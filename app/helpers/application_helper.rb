module ApplicationHelper

  def login_nav(user)

    #logger.info '=ELSE casr in HELPER='*10
    #logger.info current_user.inspect
    #logger.info '=Else -END- ='*20
    status = if user.present?

      "<input type='hidden' name='login_user_id' id='login_user_id' value=#{user.id} /><input type='hidden' name='login_user_email' id='login_user_email' value=#{user.email} /> #{link_to('Log out', logout_path, :class => 'log-Out')} <span class='loged-user'>Logged in as #{user.email}.</span>".html_safe

      else

      "<li><a class='fancybox' href='#inline2' title='login' id='fancybox'>login</a></ li>".html_safe

    end
    "<ul><li><a href='#'>Faq</a></li> #{status} </ul>".html_safe
  end



  def avatar_url(user)
    #if user.avatar_url.present?
    #  user.avatar_url
    #else
      default_url = "#{root_url}/assets/img-1.jpg"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=42" 
    #end
  end



end
