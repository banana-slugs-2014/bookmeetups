class LocationBuilder
  def initialize(zip)
    @zip = zip
  end

  def build
    get_city_state
    Location.where(state: @state, city: @city, zip: @zip).first_or_create
  end

  private
  def get_city_state
    @state = @zip.to_region(:state => true)
    @city = @zip.to_region(:city => true)
  end
end