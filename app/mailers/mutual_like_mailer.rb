class MutualLikeMailer < ActionMailer::Base
  def mutual_like_mailer(user,current_user)
    @user = User.find(user).email
    @current_user=current_user
    @gender = User.find(user).demographic.male ? "Guy" : "Gal"
    mail(to: @user, subject: 'Can we do a virtual high-five? Coz you have a mutual like!!')
  end
end
