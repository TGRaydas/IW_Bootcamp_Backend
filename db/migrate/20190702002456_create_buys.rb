class CreateBuys < ActiveRecord::Migration[5.2]
  def change
    create_table :buys do |t|
      t.integer :amount
      t.references :container, foreign_key: true
      t.timestamp :expiration_date

      t.timestamps
    end
  end
end
