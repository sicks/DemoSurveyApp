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
end
