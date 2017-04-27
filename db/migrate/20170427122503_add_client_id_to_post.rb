class AddClientIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :client_id, :string
  end
end
