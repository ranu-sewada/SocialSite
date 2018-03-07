class CustomDeviseMailer < Devise::Mailer
  layout 'mailers'
  default from: 'ranu.ongraph@example.com'

  def welcome_send(user)
  	@user = user
  	mail to: @user.email, subject: "Welcome mail", body: 'Welcome on Social Site!!!!'
  end


end