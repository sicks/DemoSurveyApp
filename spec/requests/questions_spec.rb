require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }
  let!(:survey) { create(:survey) }
  let!(:question) { create(:question, survey:) }
  let(:params) { { question: attributes_for(:question) } }

  before do
    authenticate(session)
  end

  describe "POST /surveys/:survey_id/questions" do
    before { post survey_questions_path(survey, params:, format: :turbo_stream) }

    it { expect(response).to have_http_status :ok }
  end

  describe "PUT /surveys/:survey_id/questions/:id" do
    before { put survey_question_path(survey, question, params:, format: :turbo_stream) }

    it { expect(response).to have_http_status :ok }
  end

  describe "DELETE /surveys/:survey_id/questions/:id" do
    before { delete survey_question_path(survey, question, format: :turbo_stream) }

    it { expect(response).to have_http_status :ok }
  end
end
