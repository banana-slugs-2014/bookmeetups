require 'spec_helper'

describe "Users", :js => true do
  let!(:my_user) { create :user }
  let!(:attribs) { attributes_for :user }

  it "a user can signup for an account" do
    visit new_user_path
    fill_in 'username', with: my_user.username
    fill_in 'Email', with: my_user.email
    fill_in 'Password', with: my_user.password
    fill_in 'Confirm Password', with: my_user.password_confirmation
    click_button('Sign Up')
  end

end


