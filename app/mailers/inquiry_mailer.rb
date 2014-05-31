class InquiryMailer < ActionMailer::Base
  default from: "Let's Have coffee"
  def inform_about_inquiry(user,body)
    @from_user = user
    @body = body
    mail(to: "contact@letshavecoffee.in", subject: "An inquiry has been posted on let's have coffee")
  end
end
