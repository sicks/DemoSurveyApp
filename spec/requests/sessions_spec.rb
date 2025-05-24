require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }

  describe "GET /session/new" do
    context "without authentication" do
      before { get new_session_path }

      it { expect(response).to have_http_status :ok }
    end

    context "when authenticated" do
      before do
        authenticate(session)
        get new_session_path
      end

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "POST /session" do
    context "with valid params" do
      let(:params) { { email_address: user.email_address, password: user.password } }

      before { post session_path, params: }

      it { expect(response).to redirect_to root_path }
    end

    context "with invalid params" do
      let(:params) { { email_address: user.email_address, password: "invalid" } }

      before { post session_path, params: }

      it { expect(response).not_to redirect_to root_path }
    end

    context "with new user params" do
      let(:params) { { email_address: "new@user.com", password: "password", password_confirmation: "password" } }

      before { post session_path, params: }

      it { expect(response).to redirect_to root_path }
    end

    context "when authenticated" do
      before do
        authenticate(session)
        get new_session_path
      end

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "DELETE /session" do
    before do
      authenticate(session)
      delete session_path
    end

    it { expect(response).to redirect_to new_session_path }
  end

  describe "POST /session/user" do
    context "when the user exists" do
      let(:params) { { email_address: user.email_address } }

      before { post user_session_path, params: }

      it { expect(response).to have_http_status :ok }
    end

    context "when the user doesn't exist" do
      let(:params) { { email_address: "some@email.com" } }

      before { post user_session_path, params: }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
