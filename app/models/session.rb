class Session < ApplicationRecord
  include Uuid
 
  belongs_to :user
end
