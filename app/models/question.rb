class Question < ApplicationRecord
  belongs_to :survey

  enum :question_type, %w[short_answer pick_one pick_many]
  enum :option_layout, %w[row column]

  before_validation :strip_empty_options

  validates :body, presence: true
  validate :uniqueness_of_options

  private

  def strip_empty_options
    options.map!{ |o| o.to_s.strip }.select!{ |o| o.present? }
  end

  def uniqueness_of_options
    return if options == options.uniq
    errors.add(:options, :invalid, message: "must be unique")
  end
end
