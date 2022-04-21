class AddNameToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :name, :string
  end
end
