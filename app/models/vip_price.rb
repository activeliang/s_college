class VipPrice < ApplicationRecord

  has_one :first_vip, -> { order(weight: 'desc') }, class_name: :VipPrice
end
