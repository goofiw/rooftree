class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
end

class UserMailer < ApplicationMailer

	 def deletion_email(user)
	 	@user = user
	 	mail(to: @user.email, 
	 		   subject: 'You have been deleted from Rotten Mangoes by and admin') do |format|
	 		format.html { render 'deletion_email' }
	 	end
	 end
end
