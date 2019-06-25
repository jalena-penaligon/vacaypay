class GoogleService
  attr_reader :city,
              :state

  def initialize(city, state)
    @city = city
    @state = state
  end

  def location
    location = @city + "," + @state
    # binding.pry
  end

  def get_lat_long
    coordinates = []
    coordinates[0] = get_google_data[:results][0][:geometry][:location][:lat].round(4)
    coordinates[1] = get_google_data[:results][0][:geometry][:location][:lng].round(4)
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
