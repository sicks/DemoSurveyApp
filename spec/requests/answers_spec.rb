require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }
  let!(:survey) { create(:survey_with_questions) }
  let(:short_answer_question) { survey.questions.find_by(question_type: "short_answer") }
  let(:pick_one_question) { survey.questions.find_by(question_type: "pick_one") }
  let!(:survey_response) { create(:response, survey:) }
  let!(:answer) do
    create(:answer, response: survey_response, question: pick_one_question, picks: [ pick_one_question.options.first ])
  end

  before do
    authenticate(session)
  end

  describe "POST /responses/:response_id/answers" do
    context "with valid params" do
      let(:params) { { answer: { question_id: short_answer_question.id, body: "test" } } }

      before { post response_answers_path(survey_response, params:, format: :turbo_stream) }

      it { expect(response).to have_http_status :ok }
    end

    context "with invalid params" do
      let(:params) { { answer: { question_id: short_answer_question.id, body: "" } } }

      before { post response_answers_path(survey_response, params:, format: :turbo_stream) }

      it { expect(response).to have_http_status :bad_request }
    end
  end

  describe "PATCH /responses/:response_id/answers/:id" do
    context "with valid params" do
      let(:params) { { answer: { question_id: pick_one_question.id, picks: [ pick_one_question.options.second ] } } }

      before { patch response_answer_path(survey_response, answer, params:, format: :turbo_stream) }

      it { expect(response).to have_http_status :ok }
    end

    context "with invalid params" do
      let(:params) { { answer: { question_id: pick_one_question.id, picks: [ "" ] } } }

      before { patch response_answer_path(survey_response, answer, params:, format: :turbo_stream) }

      it { expect(response).to have_http_status :bad_request }
    end
  end
end
