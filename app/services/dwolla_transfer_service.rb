class DwollaTransferService
  def initialize(source, destination, activity, token)
    @token = token
    @request_body =
    { :_links => {
           :source => {
               :href => "https://api-sandbox.dwolla.com/funding-sources/#{source}"
           },
           :destination => {
               :href => "https://api-sandbox.dwolla.com/funding-sources/#{destination}"
           }
       },
       :amount => {
           :currency => "USD",
           :value => activity.price.to_f.to_s }
    }
  end

  def create_transfer
    transfer = @token.post "transfers", @request_body
    binding.pry
  end

end
