class CreateCategorization < ActiveRecord::Migration[6.0]
  def change
    create_table :categorizations do |t|
      t.integer :event_id
      t.integer :category_id 

      t.timestamps
    end
  end
end
