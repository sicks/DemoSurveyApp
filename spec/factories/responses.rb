FactoryBot.define do
  factory :response do
    user
    survey factory: :survey_with_questions

    factory :completed_response do
      completed_at { Time.current }

      after(:build) do |response, context|
        response.survey.save!
        response.survey.questions.find_each(&:save!)
        response.survey.questions.each do |question|
          response.answers.build(question:, body: "text", picks: [ question.options.first ])
        end
      end
    end
  end
end
