class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.string :name
      t.integer :place_type
      t.string :property_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number

      t.string :address
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :country

      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
