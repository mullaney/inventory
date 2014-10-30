class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :item, index: true
      t.string :type
      t.date :date
      t.integer :amount

      t.timestamps
    end
  end
end
