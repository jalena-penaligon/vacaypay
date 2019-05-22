class CreateVacation < ActiveRecord::Migration[5.2]
  def change
    create_table :vacations do |t|
      t.string :name
      t.string :location
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
