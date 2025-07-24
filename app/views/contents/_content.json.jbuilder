json.extract! content, :id, :slug, :user_id, :content_type_id, :title, :description, :created_at, :updated_at
json.url content_url(content, format: :json)
