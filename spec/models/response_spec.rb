require 'rails_helper'

RSpec.describe Response, type: :model do
  let(:response) { build(:response) }

  it "has a valid factory" do
    expect(response.valid?).to be true
  end

  describe "validates:" do
    %w[user survey].each do |attr|
      specify "presence of #{attr}" do
        response.send("#{attr}=".to_sym, nil)
        expect(response.valid?).to be false
      end
    end

    context "when completed_at present" do
      let!(:survey) { create(:survey_with_questions) }
      let(:question_2) { survey.questions.second }
      let(:question_3) { survey.questions.third }
      let!(:response) { create(:response, survey:) }
      let!(:first_answer) { create(:answer, response:, question: survey.questions.first, body: "test") }
      let!(:second_answer) { create(:answer, response:, question: question_2, picks: [ question_2.options.first ]) }

      specify "every question is answered" do
        expect(response.valid?).to be true
        response.completed_at = Time.current
        expect(response.valid?).to be false
        response.answers.create(question: survey.questions.third, picks: [ question_3.options.first ])
        expect(response.valid?).to be true
      end
    end
  end

  describe "scopes:" do
    describe ".for_user(user)" do
      let!(:user) { create(:user) }
      let!(:user_one_response) { create(:response, user:) }
      let!(:user_two_response) { create(:response) }
      let(:collection) { Response.for_user(user) }

      it "includes responses from user" do
        expect(collection).to include(user_one_response)
        expect(collection).not_to include(user_two_response)
      end
    end
  end

  describe "#answers_for_questions" do
    let!(:survey) { create(:survey_with_questions) }
    let!(:response) { create(:response, survey:) }
    let!(:answer) { create(:answer, response:, question: survey.questions.first) }
    let(:answers_for_questions) { response.answers_for_questions }

    it "returns persisted answers if they exist, or a new record, for each question on the survey" do
      expect(answers_for_questions.first.persisted?).to be true
      expect(answers_for_questions.second.persisted?).to be false
      expect(answers_for_questions.third.persisted?).to be false
    end
  end

  describe "#name" do
    it "returns the survey name with a prefix" do
      expect(response.name).to start_with("Response to")
    end
  end

  describe "completed?" do
    let(:complete_response) { create(:completed_response) }
    let(:incomplete_response) { create(:response) }

    it "returns the presence of completed_at" do
      expect(complete_response.completed?).to be true
      expect(incomplete_response.completed?).to be false
    end
  end
end
