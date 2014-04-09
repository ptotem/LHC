namespace :data do
  desc "import data from files to database"
  task :import_site_content => :environment do

    SiteContent.create!(:key=>"landingpagetext", :value=>"Meet Guys & Girls from the best colleges")
    SiteContent.create!(:key=>"scrolldown1", :value=>"3 matches every 3 days")
    SiteContent.create!(:key=>"scrolldown1a", :value=>"Get personalized matches regularly. No more random searching through hundreds of profiles.")
    SiteContent.create!(:key=>"scrolldown2", :value=>"Like or Reject the matches")
    SiteContent.create!(:key=>"scrolldown2a", :value=>"Like the matches you find interesting. We keep your identity anonymous.")
    SiteContent.create!(:key=>"scrolldown3", :value=>"We connect mutual likes")
    SiteContent.create!(:key=>"scrolldown3a", :value=>"Talk only to those who like you too! Use our rich profiles to have great conversations.")
    SiteContent.create!(:key=>"scrolldownquote", :value=>"Good things happen over coffee Edwina Hayes")
    SiteContent.create!(:key=>"contactus1", :value=>"I want to share my story")
    SiteContent.create!(:key=>"contactus2", :value=>"I want to know more about Let's Have Coffee")
    SiteContent.create!(:key=>"contactus3", :value=>"I have an interesting proposal for you")
    SiteContent.create!(:key=>"contactus4", :value=>"I want to add my college to Let's Have Coffee")
    SiteContent.create!(:key=>"contactus5", :value=>"I just generally want to talk to you guys!")
    SiteContent.create!(:key=>"contactusside", :value=>"Have a question for us? Send us a message and we promise we'll get back to you within 48 hours!")
    SiteContent.create!(:key=>"dashboard", :value=>"Have a great time!")
    SiteContent.create!(:key=>"aboutus", :value=>"Two individuals driven by a simple goal -  To help you find your soul mate. Or at least have fun while the search continues ;-) - D & S")
    SiteContent.create!(:key=>"firstdashboard", :value=>"Let's get started!")
    SiteContent.create!(:key=>"firstdashboard1", :value=>"Fill your profile")
    SiteContent.create!(:key=>"firstdashboard2", :value=>"We would love to know you better ")
    SiteContent.create!(:key=>"firstdashboard3", :value=>"Check your matches regularly")
    SiteContent.create!(:key=>"firstdashboard4", :value=>"There's a time limit")
    SiteContent.create!(:key=>"firstdashboard5", :value=>"If you get a mutual like, send a message")
    SiteContent.create!(:key=>"firstdashboard6", :value=>"Ofcourse, you will!")
    SiteContent.create!(:key=>"firstdashboard7", :value=>"Have fun with our fun-filled trivia and tests!")
    SiteContent.create!(:key=>"firstdashboard8", :value=>"Play now!")

  end
end