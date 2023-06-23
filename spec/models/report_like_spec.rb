require 'rails_helper'

RSpec.describe ReportLike, type: :model do
  before(:each) do 
    @user = User.create(id: 1, nickname: "John", email:"test@test.com", password:"password", password_confirmation: "password")
    @report = Report.create(id: 1, title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", user_id: @user.id)
    @like = ReportLike.create(user_id: @user.id, report_id: @report.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@like).to be_a(ReportLike)
      expect(@like).to be_valid
    end
  end

  describe "destroy like" do
    it "should destroy the existing like" do
      @like.delete
      expect(ReportLike.find_by(user_id: @user.id)).to eq(nil)
    end
  end
end
