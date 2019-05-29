class ChangeDefaultValueActivity < ActiveRecord::Migration[5.2]
  def change
    change_column :activities, :num_attendees, :integer, default: 1
  end
end
