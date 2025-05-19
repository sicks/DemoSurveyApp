class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :response

  delegate :question_type, :short_answer?, :pick_one?, :pick_many?, :option_layout, to: :question, allow_nil: true

  before_validation :remove_blank_picks
  validate :presence_of_body, if: :short_answer?
  validate :exactly_one_pick, if: :pick_one?
  validate :at_least_one_pick, if: :pick_many?
  validate :presence_of_question_in_survey

  private

  def remove_blank_picks
    picks.select!(&:present?)
  end

  def presence_of_body
    return if body.present?
    errors.add(:body, :invalid, message: "is required")
  end

  def exactly_one_pick
    return if picks.length == 1
    errors.add(:picks, :invalid, message: "exactly one")
  end

  def at_least_one_pick
    return if picks.length >= 1
    errors.add(:picks, :invalid, message: "at least one")
  end

  def presence_of_question_in_survey
    return if response.present? && response.survey.question_ids.include?(question_id)
    errors.add(:question, :invalid, message: "must be from the same survey")
  end
end
