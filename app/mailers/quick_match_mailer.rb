class QuickMatchMailer < ActionMailer::Base

  helper :application
  def quick_match_email(user,current_user)
    @user = user
    #@user.each do |u|
    #  attachments.inline[User.find(u).demographic.avatar.url] = File.read("#{Rails.root}"+User.find(u).demographic.avatar.url)
    #end
    @current_user=User.find(current_user).email
    mail(to: current_user, subject: 'Hey hey hey! We have matches for you!')
  end
end
