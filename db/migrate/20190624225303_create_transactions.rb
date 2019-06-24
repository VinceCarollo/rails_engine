class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :result
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
