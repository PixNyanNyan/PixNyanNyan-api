class AddAttachmentImageToPosts < ActiveRecord::Migration[5.0]
  def up
    change_table :posts do |t|
      t.attachment :image
    end
  end

  def down
    remove_attachment :posts, :image
  end
end
