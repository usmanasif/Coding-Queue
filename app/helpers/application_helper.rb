module ApplicationHelper

  def login_nav(user)

    #logger.info '=ELSE casr in HELPER='*10
    #logger.info current_user.inspect
    #logger.info '=Else -END- ='*20
    status = if user.present?

      "#{link_to('Log out', logout_path, :class => 'log-Out')} <span class='loged-user'>Logged in as #{user.email}.</span>".html_safe

      else

      "<li><a class='fancybox' href='#inline2' title='login' id='fancybox'>login</a></ li>".html_safe

    end
    "<ul><li><a href='#'>Faq</a></li> #{status} </ul>".html_safe
  end

end
