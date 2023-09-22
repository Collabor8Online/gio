class Locations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, default: "", null: false, index: true
      t.string :reference, default: "", null: false, index: true
      t.timestamps
    end
  end
end
