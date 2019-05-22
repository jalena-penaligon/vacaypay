class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.integer :quantity
      t.decimal :price
      t.boolean :paid

      t.timestamps
    end
  end
end
