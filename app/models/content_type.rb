class ContentType < ApplicationRecord
  include Uuid
  include Slugable

  has_many :contents

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }

  def to_param
    self.slug
  end
end
