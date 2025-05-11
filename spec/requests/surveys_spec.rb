require 'rails_helper'

RSpec.describe "Surveys", type: :request do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, user:) }

  before do
    authenticate(session)
  end

  describe "GET /" do
    before { get root_path }

    it { expect(response).to have_http_status :ok }
  end
end
