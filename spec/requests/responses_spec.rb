require 'rails_helper'

RSpec.describe "Responses", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }
  let!(:survey) { create(:survey_with_questions) }
  let!(:survey_response) { create(:response, survey:) }

  before do
    authenticate(session)
  end

  describe "GET /index" do
    before { get responses_path }

    it { expect(response).to have_http_status :ok }
  end

  describe "POST /surveys/:survey_id/responses" do
    before { post survey_responses_path(survey) }

    it { expect(response).to redirect_to edit_response_path(Response.last) }
  end

  describe "GET /responses/:id" do
    before { get response_path(survey_response) }

    it { expect(response).to redirect_to edit_response_path(survey_response) }
  end

  describe "GET /responses/:id/edit" do
    before { get edit_response_path(survey_response) }

    it { expect(response).to have_http_status :ok }
  end

  describe "POST /responses/:id/complete" do
    let!(:survey_response) { create(:completed_response, survey:, completed_at: nil) }

    before { post complete_response_path(survey_response) }

    it { expect(response).to redirect_to response_path(survey_response) }
  end

  context "when response is completed" do
    let!(:survey_response) { create(:completed_response, survey:) }

    describe "GET /responses/:id" do
      before { get response_path(survey_response) }

      it { expect(response).to have_http_status :ok }
    end

    describe "GET /responses/:id/edit" do
      before { get edit_response_path(survey_response) }

      it { expect(response).to redirect_to response_path(survey_response) }
    end
  end
end
