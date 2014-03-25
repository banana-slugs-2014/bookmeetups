class Searcher
  def self.search(terms)
    terms = "" if terms==nil
    local = BookSearch.search( terms )
    if local.length < 15
      return local + GoogleSearch.search_and_add( terms, {:count => 20})
    end
    return local.uniq
  end
end