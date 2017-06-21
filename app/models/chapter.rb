class Chapter < ApplicationRecord
  belongs_to :lesson
  has_many :posts, -> { order(weight: 'asc') }, dependent: :destroy
end
