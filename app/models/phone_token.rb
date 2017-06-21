class PhoneToken < ApplicationRecord
  validates_presence_of :token
  validates_presence_of :phone
  scope :available, -> { where("expired_at > :time", time: Time.now) }

  def self.upsert phone, token
    cond = { phone: phone }
    record = self.find_by(cond)
    unless record
      record = self.create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    else
      record.update_attributes token: token, expired_at: Time.now + 10.minutes
    end
    record
  end
end
