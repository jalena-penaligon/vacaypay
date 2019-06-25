class GeoFacade
  attr_reader :city,
              :state

  def initialize(city, state)
    @city = city
    @state = state
  end

  def get_coordinates
    google_service = GoogleService.new(@city, @state).get_lat_long
  end

end
