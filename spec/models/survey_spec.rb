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
end
