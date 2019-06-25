class ActivityGoogleService
  attr_reader :street,
              :city,
              :state

  def initialize(street, city, state)
    binding.pry
    @street = street
    @city = city
    @state = state
  end

  def formatted_street
    @street.gsub(' ', '+')
  end

  def formatted_city
    @city.gsub(' ', '+')
  end

  def location
    location = formatted_street + "," + formatted_city + "," + @state
    location.downcase
    binding.pry
  end

  def get_lat_long
    coordinates = []
    coordinates[0] = get_google_data[:results][0][:geometry][:bounds][:northeast][:lat].round(4)
    coordinates[1] = get_google_data[:results][0][:geometry][:bounds][:northeast][:lng].round(4)
    coordinates
end

def get_google_data
  # Rails.cache.fetch("#{@location}/get_data_from_google", :expires_in => 15.minutes) do
    conn = Faraday.new("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyAoi4djUiwmzFeOzjJbnZ-xSLREITHPqBY&address=#{location}") do |f|
      f.adapter Faraday.default_adapter
    end
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  # end
end

end
