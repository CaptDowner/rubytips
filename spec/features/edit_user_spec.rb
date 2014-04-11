require 'spec_helper'

describe "Editing a user" do
  
  it "updates the user and shows the user's updated details" do
    user = User.create!(user_attributes)
    
    visit user_url(user)
    
    click_button 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
        
    expect(find_field('Firstname:').value).to eq(user.firstname)
    expect(find_field('Lastname:').value).to eq(user.lastname)
    expect(find_field('Email:').value).to eq(user.email)

		
    fill_in "Firstname", with: "EditedFirstName"
    fill_in "Lastname", with: "EditedLastName"
    fill_in "Email", with: "Updated@Name.net"
    
    click_button "Update User"
    
    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("EditedFirstName")
    expect(page).to have_text("EditedLastName")
    expect(page).to have_text("Updated@Name.net")
    expect(page).to have_text('Update successful!')
  end
  
  it "does not update the user if it's invalid" do
    user = User.create!(user_attributes)
    
    visit edit_user_url(user)
    
    fill_in 'Firstname', with: " "
    
    click_button "Update User"
        
    expect(page).to have_text('error')
  end
  
end
