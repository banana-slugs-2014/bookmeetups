class SearchesController < ApplicationController
  require 'googlebooks'

  def search
    redirect_to "/search/#{params[:search]}"
  end

  def results
    @books = Searcher.search(params[:s])
    render :results
  end

end