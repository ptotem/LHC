#creating a single admin user
User.create!(email:"admin@ptotem.com", password:"p20o20e13", password_confirmation:"p20o20e13", is_admin:true)


institutions_array = ["IIT Bhubaneswar", "IIT Bombay", "IIT Delhi", "IIT Gandhinagar", "IIT Guwahati", "IIT Hyderabad", "IIT Indore", "IIT Jodhpur", "IIT Kanpur", "IIT Kharagpur", "IIT Madras", "IIT Mandi", "IIT Patna", "IIT Roorkee", "IIT Ropar", "IIT (BHU) Varanasi"]

institutions_array.each_with_index do |institution, index|
  institute = Institution.create(:name=>institutions_array[index])
  institute.save!
end