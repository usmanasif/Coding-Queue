class UserMailer < ActionMailer::Base

  default :from => "Coding QnA"

  def send_update(user)
  	@user = user
    mail(:to => user.email, :subject => "Coding QnA Update")
  end

end
