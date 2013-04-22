class UserMailer < ActionMailer::Base

  default :from => "Coding QnA"

  def send_update(user, question_id)

  	@user = user
  	@question_id	=	question_id
    mail(:to => user.email, :subject => "Coding QnA Update")
  end

end
