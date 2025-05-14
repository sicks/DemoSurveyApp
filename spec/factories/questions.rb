FactoryBot.define do
  factory :question, aliases: %i[short_answer_question] do
    survey
    body { "Why?" }
    question_type { :short_answer }
    option_layout { :row }

    factory :pick_one_question do
      body { "Who?" }
      question_type { :pick_one }
      options { %w[jim bob frank] }
    end

    factory :pick_many_question do
      body { "Which?" }
      question_type { :pick_many }
      options { %w[lions tigers bears] }
    end
  end
end
