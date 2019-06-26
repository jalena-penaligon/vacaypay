class ActivityGeoFacade
  attr_reader :street,
              :city,
              :state

  def initialize(street, city, state)
    @street =street
    @city = city
    @state = state
  end

  def get_coordinates
    # binding.pry
    ActivityGoogleService.new(@street, @city, @state).get_lat_long
  end

end
