class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :restrict_with_exception

  validates :name, presence: true

  def editable?
    responses.empty?
  end
end
