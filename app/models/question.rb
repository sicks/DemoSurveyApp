class Question < ApplicationRecord
  attribute :body, default: -> { %w[Who? What? Where? When? Why? How? Which?].sample }
  belongs_to :survey

  enum :question_type, %w[short_answer pick_one pick_many]
  enum :option_layout, %w[row column]

  before_validation :strip_empty_options
  before_validation :set_default_options

  validates :body, presence: true
  validate :uniqueness_of_options

  private

  def set_default_options
    options[0] = "Option 1" if options[0].blank?
    options[1] = "Option 2" if options[1].blank?
  end

  def strip_empty_options
    options.map! { |o| o.to_s.strip }.select!(&:present?)
  end

  def uniqueness_of_options
    return if options == options.uniq
    errors.add(:options, :invalid, message: "must be unique")
  end
end
