class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.datetime :payment_date, null: false
      t.decimal :amount, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end