require 'rails_helper'

RSpec.describe "Surveys", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }
  let!(:survey) { create(:survey) }
  let(:params) { { survey: attributes_for(:survey) } }

  before do
    authenticate(session)
  end

  describe "GET /" do
    before { get root_path }

    it { expect(response).to have_http_status :ok }
  end

  describe "GET /surveys/new" do
    before { get new_survey_path }

    it { expect(response).to have_http_status :ok }
  end

  describe "POST /surveys" do
    before { post surveys_path(params:, format: :turbo_stream) }

    it { expect(response).to redirect_to(edit_survey_path(Survey.last)).and have_http_status(:found) }

    context "with invalid params" do
      let(:params) { { survey: { body: "" } } }

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe "GET /surveys/:id" do
    before { get survey_path(survey) }

    it { expect(response).to have_http_status :ok }
  end

  describe "GET /surveys/:id/edit" do
    before { get edit_survey_path(survey) }

    it { expect(response).to have_http_status :ok }
  end

  describe "PUT /surveys/:id" do
    before { put survey_path(survey, params:, format: :turbo_stream) }

    it { expect(response).to have_http_status :ok }
  end

  describe "DELETE /surveys/:id" do
    before { delete survey_path(survey) }

    it { expect(response).to redirect_to(surveys_path).and have_http_status :found }
  end

  describe "POST /surveys/generate" do
    before { post generate_surveys_path }

    it { expect(response).to redirect_to(surveys_path).and have_http_status :found }
  end
end
