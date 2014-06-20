class VerMailer < ActionMailer::Base
  default from: "Let's Have coffee"
  def ver_email(email,current_user)
    @email = email
    @current_user=current_user
    mail(to: @email, subject: 'Lets Have Coffee')
  end
end
