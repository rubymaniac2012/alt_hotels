class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :room_type
      t.decimal :price
      t.text :description
      t.integer :max_guests
      t.references :hotel
      t.timestamps
    end
  end
end
