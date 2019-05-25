class AddTypeColumnToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :type, :string, null: false
  end
end
