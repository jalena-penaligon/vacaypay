class AddUsersToVacationUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :vacation_users, :user, foreign_key: true
    add_reference :vacation_users, :vacation, foreign_key: true
  end
end
