class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.decimal :price
      t.integer :num_attendees
      t.text :description
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
