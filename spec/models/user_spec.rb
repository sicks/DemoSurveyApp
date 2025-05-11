require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "has a valid factory" do
    expect(user.valid?).to be true
  end

  describe "validates:" do
    %w[email_address password].each do |attr|
      specify "presence of #{attr}" do
        user.send("#{attr}=".to_sym, nil)
        expect(user.valid?).to be false
      end
    end
  end
end
