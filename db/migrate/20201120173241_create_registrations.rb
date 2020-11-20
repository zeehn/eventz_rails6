class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :email
      t.string :how_heard
      t.integer :event_id

      t.timestamps
    end
  end
end
