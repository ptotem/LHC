class InviteeMailer < ActionMailer::Base
  default from: "Let's Have coffee"
  def invitee_email(user,current_user)
    @user = user
    @current_user=current_user
    mail(to: @user, subject: 'Lets Have Coffee')
  end
end
