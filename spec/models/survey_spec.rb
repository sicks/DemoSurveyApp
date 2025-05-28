require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:survey) { build(:survey) }

  it "has a valid factory" do
    expect(survey.valid?).to be true
  end

  describe "validates:" do
    specify "presence of name" do
      survey.name = nil
      expect(survey.valid?).to be false
    end
  end

  describe ".create_example!" do
    it "creates a survey with 3 questions" do
      expect { Survey.create_example! }.to change { Survey.count }.by(1).and change { Question.count }.by(3)
    end
  end

  describe "#editable?" do
    let!(:responseless_survey) { create(:survey_with_questions) }
    let!(:responseful_survey) { create(:survey_with_questions) }
    let!(:response) { create(:response, survey: responseful_survey) }

    it "returns the emptiness of survey responses" do
      expect(responseless_survey.editable?).to be true
      expect(responseful_survey.editable?).to be false
    end
  end
end
