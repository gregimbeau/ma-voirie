require 'rails_helper'

RSpec.describe "ReportLikes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/report_likes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/report_likes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end