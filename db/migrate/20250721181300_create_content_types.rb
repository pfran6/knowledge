class CreateContentTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :content_types, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.string :slug
      t.string :title

      t.timestamps
    end
    add_index :content_types, :id, unique: true
    add_index :content_types, :slug, unique: true
  end
end
