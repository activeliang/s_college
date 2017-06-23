class Order < ApplicationRecord
  before_create :generate_token
  belongs_to :user
  belongs_to :payment

  
  def generate_token
    self.token = SecureRandom.uuid
  end

end
