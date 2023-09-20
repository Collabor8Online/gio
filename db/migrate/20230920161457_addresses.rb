class Addresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address, default: "", null: false, unique: true
      t.belongs_to :block, foreign_key: true
    end
  end
end
