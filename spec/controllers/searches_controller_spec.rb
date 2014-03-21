require 'spec_helper'
describe SearchesController do
  let!(:book) {FactoryGirl.create :book}
  before(:each) do
    session[:id]=1
  end
  context "results page" do
    it "displays the results page" do
      session[:id]= 1
      post :search, search: "bob"
      expect( response ).to be_success
    end

    it "displays the search bar on the results page" do
      post :search, search: book.title
      expect( response ).to be_success
      expect( response ).to include(book.title)
    end
  end
end