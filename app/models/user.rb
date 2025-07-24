class User < ApplicationRecord
  include Uuid

  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :categories
  has_many :contents

  normalizes :login, with: ->(e) { e.strip.downcase }
end
