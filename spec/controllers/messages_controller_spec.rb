require 'spec_helper'
describe MessagesController do
  let!(:test_meetup) { create :meetup }
  let(:test_message){ create :message}
  let!(:other_user) {create :user}
  let!(:current_user) { create :user }
  before(:each) { request.session[:id] = current_user.id }

  context "#new" do
    it 'should be success' do
      get :new, { :meetup_id => test_meetup.id }
      expect(response).to be_success
    end

    it 'should set a form for new message' do
      get :new, { :meetup_id => test_meetup.id }
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  context '#create' do
    let(:message_attribs) { attributes_for :message }

    it "should be redirect" do
      post :create, { :meetup_id => test_meetup.id, :message => message_attribs }
      expect(response).to be_ok
    end

    it "should create a new message" do
      expect {
        post :create, { :meetup_id => test_meetup.id, :message => message_attribs }
      }.to change { Message.count }.by(1)
    end

    it "should create a message associated the user" do
      expect {
        post :create, { :meetup_id => test_meetup.id, :message => message_attribs }
      }.to change { current_user.messages.count }.by(1)
    end
  end
end