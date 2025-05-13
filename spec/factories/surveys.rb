FactoryBot.define do
  factory :survey do
    sequence(:name) { |n| "Survey #{n}" }

    factory :survey_with_questions do
      after(:build) do |survey, context|
        survey.questions << build(:question)
        survey.questions << build(:pick_one_question)
        survey.questions << build(:pick_many_question)
      end
    end
  end
end
