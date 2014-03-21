require 'spec_helper'

describe BooksController do
  let(:my_book) { FactoryGirl.create :book }
  let(:attribs) { FactoryGirl.attributes_for :book }

  context '#create' do
    context "with valid attributes" do
      xit "should redirect" do
        post :create, book: attribs
        expect(response).to be_redirect
      end
    end
  end

  context '#show' do
    it "should be ok" do
      get :show, id: my_book.id
      expect(response).to be_success
    end

    it "should get the correct book" do
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

