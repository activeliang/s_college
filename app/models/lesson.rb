class Lesson < ApplicationRecord
  mount_uploader :main_image, MainImageUploader
  mount_uploader :minor_image, MinorImageUploader


  belongs_to :category
  has_many :posts, -> { order(weight: 'asc') },
    dependent: :destroy
  has_many :chapters, -> { order(weight: 'asc') },
    dependent: :destroy
end
