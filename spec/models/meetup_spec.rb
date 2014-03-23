require 'spec_helper'

describe Meetup do
  context "associations" do
    it { should have_many(:user_meetups) }
    it { should have_many(:users).through(:user_meetups)}
    it { should have_many(:messages) }
    it { should belong_to(:book)}
  end

end