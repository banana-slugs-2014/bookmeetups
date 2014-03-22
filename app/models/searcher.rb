class Searcher
  def self.search(terms)
    local = BookSearch.search( terms )
    if local.length < 5
      return local + GoogleSearch.search_and_add( terms, {:count => 10})
    end
    local
  end
end