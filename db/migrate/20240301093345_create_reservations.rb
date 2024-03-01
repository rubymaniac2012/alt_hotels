class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :hotel
      t.references :user
      t.references :room
      t.date :check_in
      t.date :check_out
      t.decimal :price
      t.integer :guests
      t.integer :rooms
      t.string :status
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
