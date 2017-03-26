class RemoveImage < ActiveRecord::Migration[5.0]
  def change
    remove_column :images, :image, :string 
  end
end
