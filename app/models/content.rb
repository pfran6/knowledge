class Content < ApplicationRecord
  include Uuid
  include Slugable

  belongs_to :user
  belongs_to :content_type
  has_and_belongs_to_many :categories, join_table: :contents_categories

  has_rich_text :body
  has_many_attached :attachements

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true, uniqueness: true, length: { maximum: 255 }

  def to_param
    self.slug
  end
end
