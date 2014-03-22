require 'spec_helper'

describe "Users", :js => false do
  let!(:user) { create :user }
  let!(:attribs) { attributes_for :user }

  it "a user can signup for an account" do
    visit new_user_path
    assigns(:user).should be_a_new(User)
  end



end