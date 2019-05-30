class AddVacationIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :vacation, index: true
  end
end
