class Category < ApplicationRecord
  include Uuid
  include Slugable

  belongs_to :user
  has_and_belongs_to_many :contents, join_table: :contents_categories

  has_rich_text :body
  has_one_attached :image

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true, uniqueness: true, length: { maximum: 255 }

  def to_param
    self.slug
  end

  def can_update?
    self.user == Current.user
  end
end
