require 'spec_helper'
describe SearchesController do
  let!(:book) {FactoryGirl.create :book}
  before(:each) { session[:id] = 1 }

  context '#search' do
    it "redirects when posed to" do
      post :search, search: "bob"
      expect( response ).to be_redirect
    end
  end

  context '#results' do
    it "finds the searched term in our database" do
      GoogleSearch.stub(:search_and_add) { [] }
      get :results,  :s => book.title
      expect( assigns(:books) ).to eq([book])
    end
  end
end