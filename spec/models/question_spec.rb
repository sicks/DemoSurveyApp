require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }
  let(:pick_one_question) { build(:pick_one_question) }
  let(:pick_many_question) { build(:pick_many_question) }

  it "has a valid default factory" do
    expect(question.valid?).to be true
  end

  it "has a valid pick_one factory" do
    expect(pick_one_question.valid?).to be true
  end

  it "has a valid pick_many factory" do
    expect(pick_many_question.valid?).to be true
  end

  describe "validates:" do
    %w[survey body].each do |attr|
      specify "presence of #{attr}" do
        question.send("#{attr}=".to_sym, nil)
        expect(question.valid?).to be false
      end
    end

    context "when question_type is pick_one" do
      let(:one_option_question) { build(:pick_one_question, options: [ "one" ]) }
      let(:no_option_question) { build(:pick_one_question, options: []) }
      let(:dup_option_question) { build(:pick_one_question, options: [ "same", "same" ]) }

      it "must have multiple options" do
        expect(one_option_question.valid?).to be false
        expect(no_option_question.valid?).to be false
      end

      it "must have unique options" do
        expect(dup_option_question.valid?).to be false
      end
    end

    context "when question_type is pick_many" do
      let(:one_option_question) { build(:pick_many_question, options: [ "one" ]) }
      let(:no_option_question) { build(:pick_many_question, options: []) }
      let(:dup_option_question) { build(:pick_many_question, options: [ "same", "same" ]) }

      it "must have multiple options" do
        expect(one_option_question.valid?).to be false
        expect(no_option_question.valid?).to be false
      end

      it "must have unique options" do
        expect(dup_option_question.valid?).to be false
      end
    end
  end
end
