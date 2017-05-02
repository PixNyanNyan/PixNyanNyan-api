class EnablePgroonga < ActiveRecord::Migration[5.0]
  def change
    enable_extension('pgroonga')

    add_index :posts, :title, using: :pgroonga
    add_index :posts, :author, using: :pgroonga
    add_index :posts, :email, using: :pgroonga
    add_index :posts, :message, using: :pgroonga
    add_index :posts, :client_id
    add_index :posts, :delete_password
  end
end
