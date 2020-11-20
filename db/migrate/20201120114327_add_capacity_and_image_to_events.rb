class AddCapacityAndImageToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :capacity, :integer, default: 1
    add_column :events, :image_file_name, :string, default: 'placeholder.png'
  end
end
