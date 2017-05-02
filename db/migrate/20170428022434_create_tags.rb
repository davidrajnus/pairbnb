class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.belongs_to :listing
      t.integer :property_type
      t.integer :room_type
      t.integer :wifi
      t.integer :kitchen

      t.timestamps
    end
  end
end
