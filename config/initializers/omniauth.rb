Rails.application.config.middleware.use OmniAuth::Builder do
  provider :paypal_oauth2, ENV['PAYPAL_CLIENT_ID'], ENV['PAYPAL_CLIENT_SECRET']
end
