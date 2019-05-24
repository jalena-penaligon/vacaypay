class SandboxPaypalService
  #PayPalOAuthService

  def initialize(auth_code)
    @auth_code = auth_code
  end

  def paypal_info
    get_json(conn,'/v1/identity/oauth2/userinfo?schema=paypalv1.1')
  end

  def access_token
    post_json(conn_2, '/v1/oauth2/token')[:access_token]
  end

  # def refresh_token
  #   binding.pry
  #   get_json(conn)['refresh_token']
  # end

  private

  def post_json(conn_type, url = nil)
    response = conn_type.post(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_json(conn_type, url = nil)
    response = conn_type.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    #url > env
    Faraday.new(url: 'https://api.sandbox.paypal.com') do |f|
      f.adapter Faraday.default_adapter
      f.authorization :Bearer, access_token
    end
  end

  def conn_2
    Faraday.new(url: 'https://api.sandbox.paypal.com') do |f|
      f.request :url_encoded
      f.adapter Faraday.default_adapter
      # f.headers['Authorization'] = "#{ENV['PAYPAL_CLIENT_ID']}:#{ENV['PAYPAL_CLIENT_SECRET']}"
      # f.body = ['grant_type'] = "authorization_code"
      f.params['code'] = @auth_code
      f.params['grant_type'] = 'authorization_code'
      f.basic_auth(ENV['PAYPAL_CLIENT_ID'], ENV['PAYPAL_CLIENT_SECRET'])

    end
  end
  #
  # def conn_2
  #   Faraday.new(url: 'https://api.sandbox.paypal.com/v1/oauth2/token') do |f|
  #     f.adapter Faraday.default_adapter
  #     f.headers['Authorization'] = "#{ENV['PAYPAL_CLIENT_ID']}:#{ENV['PAYPAL_CLIENT_SECRET']}"
  #     f.body = "{"grant_type": "refresh_token", "refresh_token": #{refresh_token} }"
  #   end
  # end

  # def conn_3
  #
  # end

end
