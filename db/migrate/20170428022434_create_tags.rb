class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.belongs_to :listing
      t.boolean :wifi
      t.boolean :kitchen
      t.boolean :parking
      t.boolean :smoking
      t.boolean :pool
      t.boolean :gym

      t.timestamps
    end
  end
end
