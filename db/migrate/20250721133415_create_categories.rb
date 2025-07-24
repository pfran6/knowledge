class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.string :slug
      t.string :title
      t.string :description
      t.references :user, null: false, foreign_key: true, type: :string

      t.timestamps
    end
    add_index :categories, :id, unique: true
    add_index :categories, :slug, unique: true
  end
end
