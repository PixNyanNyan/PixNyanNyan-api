class CreateBlocklist < ActiveRecord::Migration[5.0]
  def change
    create_table :blocklists do |t|
      t.string :description
      t.string :image_hash
      t.inet :ip
      t.string :client_id

      t.timestamps null: false
      t.datetime :blocked_until, null: false

      t.index :image_hash
      t.index 'ip inet_ops', using: 'gist'
      t.index :client_id
      t.index :blocked_until
    end
  end
end
