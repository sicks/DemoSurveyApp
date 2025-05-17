require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }

  it "has a valid factory" do
    expect(question.valid?).to be true
  end

  describe "validates:" do
    %w[survey body].each do |attr|
      specify "presence of #{attr}" do
        question.send("#{attr}=".to_sym, nil)
        expect(question.valid?).to be false
      end
    end

    specify "uniqueness of options" do
      question.options = [ "same", "same" ]
      expect(question.valid?).to be false
    end
  end

  describe "callbacks:" do
    specify "blank options are stripped before validation" do
      question.options = [ nil, "", " ", " test " ]
      question.validate
      expect(question.options).to eq [ "test" ]
    end
  end
end
