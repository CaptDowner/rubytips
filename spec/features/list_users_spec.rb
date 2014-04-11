require 'spec_helper'

describe "Viewing the list of users" do
  
  it "shows the users" do
    user1 = User.create!(user_attributes(firstname: "Larry", lastname: "Stooge", email: "larry@example.com"))
    user2 = User.create!(user_attributes(firstname: "Moe", lastname: "Stooge",  email: "moe@example.com"))
    user3 = User.create!(user_attributes(firstname: "Curly", lastname: "Stooge",email: "curly@example.com"))
    
    visit users_path
    
     expect(page).to have_text(user1.firstname)
     expect(page).to have_text(user1.lastname)
     expect(page).to have_text(user1.email)
     expect(page).to have_text(user2.firstname)
     expect(page).to have_text(user2.lastname)
     expect(page).to have_text(user2.email)
     expect(page).to have_text(user3.firstname)
     expect(page).to have_text(user3.lastname)
     expect(page).to have_text(user3.email)
  end
  
end
