FactoryBot.define do
  factory :answer, aliases: %i[short_answer] do
    response
    question { build(:short_answer_question) }
    body { "test" }

    factory :pick_one_answer do
      question { build(:pick_one_question) }
    end

    factory :pick_many_answer do
      question { build(:pick_many_question) }
    end
  end
end
