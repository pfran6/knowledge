json.extract! category, :id, :slug, :title, :description, :user_id, :created_at, :updated_at
json.url category_url(category, format: :json)
