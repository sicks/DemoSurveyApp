class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :answers

  scope :for_user, ->(user) { where(user: user) }

  validate :presence_of_answers_for_every_question, if: :completed_at_changed?

  def answers_for_questions
    survey.questions.map do |q|
      answers.find_or_initialize_by(question: q)
    end
  end

  def name
    "Response to #{survey.name}"
  end

  def completed?
    completed_at.present?
  end

  private

  def presence_of_answers_for_every_question
    return if completed_at.nil? || answers.size == survey.questions.size
    errors.add(:base, :invalid, message: "Every question must be answered")
  end
end
