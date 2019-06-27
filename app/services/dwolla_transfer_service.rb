class DwollaTransferService
  def initialize(source, destination, user_activity, token)
    @token = token
    @user_activity = user_activity
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
           :value => user_activity.price.to_f.to_s }
    }
  end

  def create_transfer
    destination_user = Activity.find(@user_activity.activity_id).owner
    transfer = @token.post "transfers", @request_body
    if transfer.response_status == 201
      DwollaTransferMailer.transfer(@user_activity.user_name, destination_user, @request_body).deliver_now
    end
  end
end
