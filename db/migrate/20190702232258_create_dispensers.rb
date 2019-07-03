class CreateDispensers < ActiveRecord::Migration[5.2]
  def change
    create_table :dispensers do |t|
      t.string :ble_id
      t.string :address

      t.timestamps
    end
  end
end
