class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
end
