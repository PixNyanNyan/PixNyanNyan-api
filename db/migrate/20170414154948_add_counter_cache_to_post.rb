class AddCounterCacheToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :reply_count, :integer
  end
end
