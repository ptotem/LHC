namespace :data do
  desc "import data from files to database"
  task :import_users => :environment do

    users_array = ["Nilesh", "Deepak", "Rakesh", "Swapnil", "Amol", "Rushabh", "Sachin", "Sunny", "Satya"]
    gender_array = [true, false]

    smoking_demographic_array = ["Never", "Often", "Socially"]
    drinking_demographic_array = ["Never", "Often", "Socially"]

    smoking_criterions_array = ["Never", "Often", "Socially", "Doesn't Matter"]
    drinking_criterions_array = ["Never", "Often", "Socially", "Doesn't Matter"]

    users_array.each_with_index do |user, index|
      user_name = "#{users_array[index]}"
      user_name_downcased = "#{user_name.downcase}"
      user = User.create!(email: "#{user_name_downcased}@ptotem.com" , password:"p20o20e13", password_confirmation:"p20o20e13", is_admin:false)
      random_date = rand(Date.civil(1987, 1, 1)..Date.civil(1990, 12, 31))
      user_dempgraphic = user.build_demographic(:name=>user_name, :male=>gender_array.sample, :dob=>random_date, :religion=>"Hindu", :smoking=>smoking_demographic_array.sample, :drinking=>drinking_demographic_array.sample)
      user_dempgraphic.save!

      user_criterion = user.build_criterion(:male=>gender_array.sample, :minage=>rand(18..26), :maxage=>rand(18..26), :smoking=>smoking_criterions_array.sample, :drinking=>drinking_criterions_array.sample)

      user_criterion.save!

      user.save!
    end

  end
end