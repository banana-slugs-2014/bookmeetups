class SearchesController < ApplicationController
  require 'googlebooks'

  def search
    redirect_to "/searches#results" s: params[:search]
  end

  def results
    Searcher.search(:s)
    @books = BookSearch.search( params[ :search ] )
    render :results
  end

end