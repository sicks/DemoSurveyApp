class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :response

  delegate :question_type, :short_answer?, :pick_one?, :pick_many?, to: :question

  validate :presence_of_body, if: :short_answer?
  validate :exactly_one_pick, if: :pick_one?
  validate :at_least_one_pick, if: :pick_many?

  def presence_of_body
    return if body.present?
    errors.add(:body, :invalid, message: "is required")
  end

  def exactly_one_pick
    return if picks.length == 1
    errors.add(:base, :invalid, message: "Pick exactly one")
  end

  def at_least_one_pick
    return if picks.length >= 1
    errors.add(:base, :invalid, message: "Pick at least one")
  end
end
