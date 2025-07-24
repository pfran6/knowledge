module Uuid
  extend ActiveSupport::Concern

  included do
    validates :id, presence: true, uniqueness: true, length: { maximum: 36 }

    before_validation :generate_uuid, on: [ :create ]
  end

  private

  def generate_uuid
    self.id = SecureRandom.uuid
  end
end
