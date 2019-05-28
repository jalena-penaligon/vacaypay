class VacayInviterMailer < ApplicationMailer

  def invite(user, emails, vacation)
    @user = user
    @vacation = vacation
    emails.each do |person|
      mail(to: person, subject: "#{@user.first_name} #{@user.last_name} invites you to a new vacation!")
    end
  end

end
