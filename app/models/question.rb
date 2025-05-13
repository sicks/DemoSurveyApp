class Question < ApplicationRecord
  belongs_to :survey

  enum :question_type, %w[short_answer pick_one pick_many]

  validates :body, presence: true
  validate :presence_of_options_when_pick_one_many

  private

  def presence_of_options_when_pick_one_many
    if (pick_one? || pick_many?) && options.length < 2
      errors.add(:base, :invalid, message: "More than one option is required for pick one/many")
    end
  end
end
