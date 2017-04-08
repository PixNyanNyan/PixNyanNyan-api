class PostAddTripcode < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :tripcode, :string
  end
end
