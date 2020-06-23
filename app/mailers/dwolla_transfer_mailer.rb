class DwollaTransferMailer < ApplicationMailer
  default from: "VacayPay@company.me"

  def transfer(source_user_full_name, destination_user, body)
    @source_user_full_name = source_user_full_name
    @destination_user = destination_user
    @body = body
    mail(to: destination_user.email, subject: "#{source_user_full_name} just paid you!")
  end
end
