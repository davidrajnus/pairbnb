class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.string :name
      t.string :address
      t.string :type
      t.boolean :smoking
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
