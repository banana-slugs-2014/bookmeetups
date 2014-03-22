require 'spec_helper'

describe User, :js => true do
  let!(:my_user) { create :user }
  let!(:attribs) { attributes_for :user }

  it "a user can signup for an account" do
    visit new_user_path
    fill_in 'username', with: my_user.username
    fill_in 'Email', with: my_user.email
    fill_in 'Password', with: my_user.password
    fill_in 'Confirm Password', with: my_user.password_confirmation
    click_link 'Sign Up'
    expect(page).to have_content(my_user.username)
  end

  it "a user can login" do
    visit new_session_path
    fill_in 'username', with: my_user.username
    fill_in 'password', with: my_user.password
  end

  it "a user can logout" do
    visit root_path
    click_link "Log Out"
  end

end


