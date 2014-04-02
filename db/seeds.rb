


#creating a single admin user
User.create!(email:"admin@ptotem.com", password:"p20o20e13", password_confirmation:"p20o20e13", is_admin:true)

#@ud = @user.build_demographic(:name=>"Nilesh", :male=>false, :religion=>"Hindu", :smoking=>"Never", :drinking=>"Never")

#@uc = @user.criterions.create(:male=>false, :minage=>18, :maxage=>25, :smoking=>"Never", :drinking=>"Doesn't Matter")

#@quest = Question.create(:revelation_style=>"Communication")
#@quest = Question.create(:revelation_style=>"Assertiveness")
#@quest = Question.create(:revelation_style=>"Relationship")
#@quest = Question.create(:revelation_style=>"Conflict Resolution")