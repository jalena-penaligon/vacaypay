class DwollaCustomerService


  def initialize(user, user_params, token)
    @token = token
    @request_body = {
      :firstName => user.first_name,
      :lastName => user.last_name,
      :email => user.email,
      :type => 'personal',
      :address1 => user_params[:address],
      :city => user_params[:city],
      :state => user_params[:state],
      :postalCode => user_params[:postal_code],
      :dateOfBirth => user_params[:dob],
      :ssn => user_params[:ssn]
    }
  end

  def create_verified_user
    customer = @token.post "customers", @request_body
  end

  private

end
