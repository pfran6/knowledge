class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.string :login, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :id, unique: true
    add_index :users, :login, unique: true
  end
end
