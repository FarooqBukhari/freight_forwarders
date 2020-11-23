class UserNotifierMailer < ApplicationMailer
  default :from => 'crickethowzat7@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_inquiry_email(user, inquiry)
    @user = user
    @inquiry = inquiry
    mail( :to => @user.email,
          :subject => 'A New Inquiry In Your Network' )
  end
end
