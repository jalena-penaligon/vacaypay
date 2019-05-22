class AddActivityToUserActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_activities, :activity, foreign_key: true
    add_reference :user_activities, :user, foreign_key: true
  end
end
