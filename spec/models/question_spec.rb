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
  end
end
