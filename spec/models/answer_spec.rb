require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build(:answer) }

  it "has a valid factory" do
    expect(answer.valid?).to be true
  end

  describe "validates" do
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
end
