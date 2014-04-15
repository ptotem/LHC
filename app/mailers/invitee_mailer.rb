class InviteeMailer < ActionMailer::Base
  default from: "from@example.com"
  def invitee_email(user)
    @user = user
    mail(to: @user, subject: 'Lets Have Coffee')
  end
end
