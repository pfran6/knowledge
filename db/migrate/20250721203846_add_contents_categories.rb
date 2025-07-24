class AddContentsCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :contents_categories, id: false do |t|
      t.belongs_to :content, type: :string
      t.belongs_to :category, type: :string
    end
  end
end
