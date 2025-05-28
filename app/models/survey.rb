class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :restrict_with_exception

  validates :name, presence: true

  def self.create_example!
    ActiveRecord::Base.transaction do
      survey = create!(name: "Example Survey")
      survey.questions.create!
      survey.questions.create!(body: "Rate something from 1-5",
                               question_type: :pick_one, options: [ "1", "2", "3", "4", "5" ])
      survey.questions.create!
      survey
    end
  end

  def editable?
    responses.empty?
  end
end
