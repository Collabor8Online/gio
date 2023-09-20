class Blocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.string :range, default: "", null: false, unique: true
      t.belongs_to :location, foreign_key: true
    end
  end
end
