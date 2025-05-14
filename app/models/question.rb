class Question < ApplicationRecord
  belongs_to :survey

  enum :question_type, %w[short_answer pick_one pick_many]
  enum :option_layout, %w[row column]

  validates :body, presence: true
  validate :minimum_number_of_options
  validate :options_are_unique

  private

  def minimum_number_of_options
    return unless !short_answer? && options.length < 2
    errors.add(:base, :invalid, message: "More than one option is required for pick one/many")
  end

  def options_are_unique
    options.select! { |v| !v.strip.blank? }
    return unless !short_answer? && options.length != options.uniq.length
    errors.add(:base, :invalid, message: "Options must be unique")
  end
end
