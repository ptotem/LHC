class QuickMatchMailer < ActionMailer::Base
  default from: "Let's Have coffee"
  helper :application
  def quick_match_email(user,current_user)
    @user = user
    #@user.each do |u|
    #  attachments.inline[User.find(u).demographic.avatar.url] = File.read("#{Rails.root}"+User.find(u).demographic.avatar.url)
    #end
    @current_user=User.find(current_user)
    mail(to: @current_user.email, subject: 'Hey hey hey! We have matches for you!')
  end
end
