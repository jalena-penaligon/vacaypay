class ChangeVacations < ActiveRecord::Migration[5.2]
  def change
    rename_column :vacations, :location, :city
    add_column :vacations, :state, :string
    add_column :vacations, :country, :string
  end
end
