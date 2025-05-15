class Survey < ApplicationRecord
  has_many :responses
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :name, presence: true
  validates_associated :questions
end
