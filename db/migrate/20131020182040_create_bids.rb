class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :item, index: true, null: false
      t.string :color, null: false
      t.integer :amount, null: false
      t.boolean :reserve_met, null: false
      t.datetime :timestamp, null: false

      t.timestamps
    end
  end
end
