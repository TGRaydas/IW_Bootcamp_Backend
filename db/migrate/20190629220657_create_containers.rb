class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.integer :value
      t.integer :total
      t.integer :last_buy, default: 0
      t.timestamps
    end
  end
end
