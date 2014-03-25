class SearchesController < ApplicationController
  require 'googlebooks'

  def search
    s = params[:search].gsub(/\./, "")
    redirect_to "/search/#{s}"
  end

  def results
    @books = Searcher.search(params[:s])
    render :results
  end

end