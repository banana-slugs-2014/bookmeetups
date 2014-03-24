class BookSearch
  def self.search(raw)
    books = []
    term = self.format_search(raw)
    uterm = BookSearch.smart_capitalize_format(raw)
    Book.where("title LIKE ? OR author like ? OR title Like ? OR author like ?", term , term, uterm, uterm)
  end

  private

  def self.format_search(terms)
    "%#{terms}%"
  end

  def self.smart_capitalize_format(terms)
    subbed_words = %w(of the and Of The And)
    subbed_words.each {|sub| terms.gsub!(/\s#{sub}\s/, " ")}
    BookSearch.format_search(terms.split(' ').map(&:capitalize).join('%'))
  end
end