require 'rails_helper'

RSpec.describe Report, type: :model do
  
  before(:each) do 
    @user = User.create(id: 1, nickname: "John", email:"test@test.com", password:"password", password_confirmation: "password")
    @status = Status.create(id: 1, title:"status de test")
    @report = Report.create(title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", user_id: @user.id, status_id: @status.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@report).to be_a(Report)
      expect(@report).to be_valid
    end

    it "should not be valid with only title" do
      bad_report = Report.create(title: "Un trou dans la route")
      expect(bad_report).not_to be_valid
      expect(bad_report.errors.include?(:content)).to eq(true)
      expect(bad_report.errors.include?(:address)).to eq(true)
    end

    it "should not be valid without user_id" do
      bad_report = Report.create(title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", status_id: @status.id)
      expect(bad_report).not_to be_valid
    end

    it "should not be valid without status_id" do
      bad_report = Report.create(title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", user_id: @user.id)
      expect(bad_report).not_to be_valid
    end

    it "should destroy the report" do
      @report.delete
      expect(Report.find_by(title:"Un trou dans la route")).to eq(nil)
    end

    describe "test update" do
      it "shouldn't be update" do
        @report.update(status_id:2)
        expect(@report).not_to be_valid
      end 

      it "should be update" do
        @new_status = Status.create(id: 2, title:"nouveau status")
        @report.update(status_id:2)
        expect(@report).to be_valid
      end
    end
  end
end
