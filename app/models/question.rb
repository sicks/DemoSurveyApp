class Question < ApplicationRecord
  belongs_to :survey

  enum :question_type, %w[short_answer pick_one pick_many]
  enum :option_layout, %w[row column]

  before_validation :ensure_at_least_2_options

  validates :body, presence: true

  private

  def ensure_at_least_2_options
    return unless (2 - options.count).positive?
    while options.count < 2 do
      options.push("")
    end
  end
end
