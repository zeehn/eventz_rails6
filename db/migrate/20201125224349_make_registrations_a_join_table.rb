class MakeRegistrationsAJoinTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :registrations, :name
    remove_column :registrations, :email
    add_column :registrations, :user_id, :integer 
    Registration.delete_all
  end
end
