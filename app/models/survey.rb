class Survey < ApplicationRecord
  has_many :responses
  has_many :questions, dependent: :destroy

  validates :name, presence: true
end
