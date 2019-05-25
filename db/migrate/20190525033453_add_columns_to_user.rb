class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :dwolla_token, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dwolla_id, :string
    add_column :users, :dwolla_funding_source, :string
    remove_column :users, :name
    remove_column :users, :paypal_token
  end
end
