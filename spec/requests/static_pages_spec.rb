require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /map" do
    it "returns http success" do
      get "/map"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /conditions" do
    it "returns http success" do
      get "/conditions"
      expect(response).to have_http_status(:success)
    end
  end
end
