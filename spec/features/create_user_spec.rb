require 'spec_helper'

describe "Creating a new user" do 
  it "saves the user and shows the user's profile page" do    
    visit root_url
    
    click_button 'Register'
    
    expect(current_path).to eq(signup_path)
		
    fill_in "Firstname:",  with: "Example"
    fill_in "Lastname:",  with: "User"
    fill_in "Email:", with: "user@example.com"
    fill_in "Password:", with: "secret"
    fill_in "Confirm Password:", with: "secret"
    
    click_button 'Create User'

    expect(current_path).to eq(user_path(User.last))   
    
    expect(page).to have_text('Example')
    expect(page).to have_text("User")
    expect(page).to have_text("user@example.com")
    expect(page).to have_text("Registration successful!")
    
#    expect(page).not_to have_link('Sign In')
#    expect(page).not_to have_link('Sign Up')
  end
  
  it "does not save the user if it's invalid" do
    visit signup_url
    
    expect { 
      click_button 'Create User'
    }.not_to change(User, :count)
        
    expect(page).to have_text('error')
  end
end
