class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.boolean :reserve_met, null: false
      t.integer :estimate
      t.string :title, null: false
      t.string :description
      t.datetime :ends_at, null: false
      t.datetime :published_at, null: false
      t.integer :transport_price
      t.boolean :watched, null: false

      t.timestamps
    end
  end
end
