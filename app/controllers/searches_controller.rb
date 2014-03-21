class SearchesController < ApplicationController
  def search
    raw = params[:search]
    term = "%#{raw}%"
    uterm = "%#{raw.split(' ').map(&:capitalize).join(' ')}%"
    p uterm* 100
    @books = Book.where("title LIKE ? OR author like ? OR title Like ? OR author like ?", term , term, uterm, uterm)
    render :results
  end
end