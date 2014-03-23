class Searcher
  def self.search(terms)
    terms = "" if terms==nil
    local = BookSearch.search( terms )
    if local.length < 5
      return local + GoogleSearch.search_and_add( terms, {:count => 10})
    end
    return local
  end
end