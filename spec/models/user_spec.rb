require 'spec_helper'

describe User do
  let!(:my_user) { FactoryGirl.create :user }
  context "validations" do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :location_id }
  end

  context "associations" do
    it { should have_many(:favorite_books) }
    it { should have_many(:books).through(:favorite_books) }
    it { should belong_to(:location) }
    it { should have_one(:photo) }
    it { should have_many(:user_meetups) }
    it { should have_many(:meetups).through(:user_meetups) }
    it { should have_many(:messages) }
  end

  context "instance methods" do
    context '#new_unread_message' do
      it "should increment unread" do
        expect {
          my_user.new_unread_message
        }.to change { my_user.unread }.by(1)
      end
    end

    context '#friends' do
      let!(:test_book) { create :book }
      let!(:friend) { create :user }
      before(:each) do
        my_user.books << test_book
        friend.books << test_book
      end

      it "should find friends" do
        expect(my_user.friends(test_book)).to eq([friend])
      end
    end

    context '#book_friends' do
      let!(:test_book) { create :book }
      let!(:friend) { create :user }
      before(:each) do
        my_user.books << test_book
        friend.books << test_book
      end

      it "should return an array of friends" do
        expect(my_user.book_friends).to eq([friend])
      end
    end
  end
end