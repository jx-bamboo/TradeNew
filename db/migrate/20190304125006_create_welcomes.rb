class CreateWelcomes < ActiveRecord::Migration[5.1]
  def change
    create_table :welcomes do |t|
      t.integer :types
      t.integer :market
      t.decimal :price, :precision => 10, :scale => 4
      t.decimal :number, :precision => 10, :scale => 4
      t.decimal :earn, :precision => 10, :scale => 4
      t.decimal :balance, :precision => 10, :scale => 8
      t.string :coin_name
      t.timestamps
    end
  end
end
