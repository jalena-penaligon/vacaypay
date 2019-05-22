class CreateVacationUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :vacation_users do |t|
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
