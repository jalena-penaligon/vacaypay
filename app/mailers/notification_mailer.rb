class NotificationMailer < ApplicationMailer

 def notify(user, emails, vacation_id)
   @user = user
   @vacation = Vacation.find(vacation_id)
     mail(to: emails, subject: "#{@user.first_name} #{@user.last_name} has added you to a vacation!")
 end

end
