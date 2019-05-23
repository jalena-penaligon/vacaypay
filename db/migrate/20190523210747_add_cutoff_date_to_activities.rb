class AddCutoffDateToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :cutoff_date, :date
    change_column :activities, :num_attendees, :integer, default: 0
  end
end
