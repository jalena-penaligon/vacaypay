class ChangePaidDefaultFalseToUserActivity < ActiveRecord::Migration[5.2]
  def change
    change_column :user_activities, :paid, :boolean, default: false
  end
end
