require 'spec_helper'

describe BooksController do
  let!(:my_user) { create :user }
  let(:my_book) { create :book }
  let(:attribs) { attributes_for :book }
  before(:each) { request.session[:id] = my_user.id }

  context '#show' do
    it "should be ok" do
      User.any_instance.stub(:friends).and_return([])
      get :show, id: my_book.id
      expect(response).to be_success
    end

    it "should get the correct book" do
      User.any_instance.stub(:friends).and_return([])
      get :show, id: my_book.id
      expect(assigns(:book)).to eq(Book.find(my_book.id))
    end
  end

  context '#index' do
    it "should be ok" do
      get :index
      expect(response).to be_success
    end

    it "should list all current books" do
      get :index
      expect(assigns(:books)).to eq(Book.all)
    end
  end
end

