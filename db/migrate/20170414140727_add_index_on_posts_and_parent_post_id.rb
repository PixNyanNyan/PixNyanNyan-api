class AddIndexOnPostsAndParentPostId < ActiveRecord::Migration[5.0]
  def change
    # Remove unused index
    remove_index :admins, name: 'index_admins_on_reset_password_token'
    # Important index for latest_replies scope
    add_index :posts, [:parent_post_id, :id]
    # Make lookup easier
    add_index :posts, :identity_hash
    add_index :posts, :ip
    add_index :posts, :admin_id
    add_index :posts, :tripcode
  end
end
