class AddColumnDaysOfToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :no_of_days, :integer, default: 1
    remove_column :activities, :date
  end
end
