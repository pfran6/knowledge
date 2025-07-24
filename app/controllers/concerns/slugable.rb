module Slugable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true, uniqueness: true, length: { maximum: 255 }

    before_validation :generate_slug, on: [ :create ]

    def to_param
      self.slug
    end
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end

end
