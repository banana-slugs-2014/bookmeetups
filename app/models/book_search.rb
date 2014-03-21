class BookSearch
  def search(raw)
    term = "%#{raw}%"
    uterm = "%#{raw.split(' ').map(&:capitalize).join(' ')}%"
    Book.where("title LIKE ? OR author like ? OR title Like ? OR author like ?", term , term, uterm, uterm)
  end
end