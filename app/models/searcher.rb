class Searcher
  def search(terms)
    (GoogleSearch.search_and_add( terms ) + BookSearch.search( terms )).uniq
  end
end