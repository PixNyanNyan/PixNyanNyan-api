class CreateTableComplaint < ActiveRecord::Migration[5.0]
  def change
    create_table :complaints do |t|
      t.string :name
      t.string :email
      t.string :ip, null: false
      t.string :status, default: 'open', null: false
      t.integer :post_id
      t.text :message, null: false

      t.timestamps null: false

      t.index :status
    end
  end
end
