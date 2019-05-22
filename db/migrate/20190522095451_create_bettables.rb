class CreateBettables < ActiveRecord::Migration[5.2]
  def change
    create_table :bettables do |t|
      t.string :name
      t.text :desription

      t.decimal :odds
      t.string :odd_type

      t.integer :betch_id

      t.integer :seed
      t.integer :final_ranking

      t.timestamps
    end

    add_index :bettables, :betch_id
  end
end
