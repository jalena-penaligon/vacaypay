class ChangeVacationsForCoordinates < ActiveRecord::Migration[5.2]
  def change
    add_column :vacations, :latitude, :float
    add_column :vacations, :longitude, :float
  end
end
