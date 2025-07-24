class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.string :slug
      t.references :user, null: false, foreign_key: true, type: :string
      t.references :content_type, null: false, foreign_key: true, type: :string
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :contents, :id, unique: true
    add_index :contents, :slug, unique: true
  end
end
