class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :address
      t.string :postal_code
      t.string :name
      t.integer :shipping_cost
      t.integer :total_amount
      t.integer :payment_method, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
