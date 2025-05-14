FactoryBot.define do
  factory :survey do
    sequence(:name) { |n| "Survey #{n}" }

    factory :survey_with_questions do
      after(:build) do |survey, context|
        survey.questions << build(:question, survey: survey)
        survey.questions << build(:pick_one_question, survey: survey)
        survey.questions << build(:pick_many_question, survey: survey)
      end
    end
  end
end
