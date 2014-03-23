require 'spec_helper'
describe MessagesController do
  let!(:meetup) { create :meetup }
  let(:message){ create :message}
  let!(:other_user) {create :user}
  let!(:current_user) { create :user }

  context "#create" do
    it 'should be success'
    it 'should add a message to the meetup'
  end


end