require 'spec_helper'

describe Location do
  context "validations" do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }

  end

  context "associations" do
    it { should have_many(:users) }
  end

  context "methods" do
    # let!(:user1) { User.create }
    # let!(:user2) { User.create }
    # let!(:book) { Book.create }
    # let!(:location) {Location.create}
    # let!(:location) {Location.create}

    describe ".in_range" do

      xit "finds a user with the same book at the same location" do
        # user1.books << book
        # user2.books << book
        # location.users << user1
        # location.users << user2
        # puts location
        # expect(user1.location).to eq location
        # expect(user1.book_friends).to eq [user2]
      end

      xit "finds a user with the same book at a differnt but in range location" do

      end

      xit "does not find any users when users with the same books are out of range" do

      end
    end
  end

end
