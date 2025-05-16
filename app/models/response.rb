class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :answers

  scope :for_user, ->(user) { where(user: user) }
end
