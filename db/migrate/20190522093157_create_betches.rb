class CreateBetches < ActiveRecord::Migration[5.2]
  def change
    create_table :betches do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at

      t.decimal :stake, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
