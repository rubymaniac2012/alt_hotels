class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.text :name
      t.text :city
      t.string :contact
      t.string :email
      t.timestamps
    end
  end
end
