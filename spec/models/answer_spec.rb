require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build(:answer) }
  let(:survey) { create(:survey_with_questions) }
  let(:other_survey) { create(:survey_with_questions) }
  let(:response) { create(:response, survey:) }
  let(:persisted_answer) { create(:answer, response:, question: survey.questions.first) }

  it "has a valid factory" do
    expect(answer.valid?).to be true
  end

  describe "validates" do
    %w[question response].each do |attr|
      specify "presence of #{attr}" do
        answer.send("#{attr}=".to_sym, nil)
        expect(answer.valid?).to be false
      end
    end

    specify "presence of question in responses's survey" do
      expect(persisted_answer.valid?).to be true
      persisted_answer.question = other_survey.questions.first
      expect(persisted_answer.valid?).to be false
    end

    context "when short_answer" do
      let(:has_body) { build(:short_answer, body: "test", picks: []) }
      let(:one_pick) { build(:short_answer, body: "", picks: [ "one" ]) }
      let(:two_picks) { build(:short_answer, body: "", picks: [ "one", "two" ]) }

      specify "presence of body" do
        expect(has_body.valid?).to be true
        expect(one_pick.valid?).to be false
        expect(two_picks.valid?).to be false
      end
    end

    context "when pick_one" do
      let(:has_body) { build(:pick_one_answer, body: "test", picks: []) }
      let(:one_pick) { build(:pick_one_answer, body: "", picks: [ "one" ]) }
      let(:two_picks) { build(:pick_one_answer, body: "", picks: [ "one", "two" ]) }

      specify "exactly one pick" do
        expect(has_body.valid?).to be false
        expect(one_pick.valid?).to be true
        expect(two_picks.valid?).to be false
      end
    end

    context "when pick_many" do
      let(:has_body) { build(:pick_many_answer, body: "test", picks: []) }
      let(:one_pick) { build(:pick_many_answer, body: "", picks: [ "one" ]) }
      let(:two_picks) { build(:pick_many_answer, body: "", picks: [ "one", "two" ]) }

      specify "at least one pick" do
        expect(has_body.valid?).to be false
        expect(one_pick.valid?).to be true
        expect(two_picks.valid?).to be true
      end
    end
  end

  describe "callbacks:" do
    specify "blank picks are removed before validation" do
      answer.picks = [ "", "", "", "frank" ]
      answer.validate
      expect(answer.picks).to eq [ "frank" ]
    end
  end
end
