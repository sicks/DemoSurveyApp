class Survey < ApplicationRecord
  has_many :questions
  accepts_nested_attributes_for :questions

  validates :name, presence: true
end
