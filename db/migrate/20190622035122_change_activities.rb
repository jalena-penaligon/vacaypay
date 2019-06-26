class ChangeActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :street, :string
    add_column :activities, :city, :string
    add_column :activities, :state, :string
    add_column :activities, :postal_code, :string
    add_column :activities, :country, :string
    add_column :activities, :latitude, :float
    add_column :activities, :longitude, :float
  end
end
