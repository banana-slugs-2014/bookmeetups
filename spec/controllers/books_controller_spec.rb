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
      get :show, id: my_book
      expect(response).to be_success
    end
  end

end
