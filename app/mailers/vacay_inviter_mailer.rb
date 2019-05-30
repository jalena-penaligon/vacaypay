class VacayInviterMailer < ApplicationMailer

  def invite(user, email, vacation)
    @user = user
    @vacation = vacation
    mail(to: email, subject: "#{@user.first_name} #{@user.last_name} invites you to a new vacation!")
  end
end
