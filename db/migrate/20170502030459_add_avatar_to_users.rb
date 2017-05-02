class AddAvatarToUsers < ActiveRecord::Migration[5.0]
  def change
    #it is a string for a single image upload, for multiple it will be different
    add_column :users, :avatar, :string
  end
end
