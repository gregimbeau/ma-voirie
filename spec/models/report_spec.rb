require 'rails_helper'

RSpec.describe Report, type: :model do
  
  before(:each) do 
    @user = User.create(id: 1, nickname: "John", email:"test@test.com", password:"password", password_confirmation: "password")
    @report = Report.create(title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", user_id: @user.id)
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
      bad_report = Report.create(title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare")
      expect(bad_report).not_to be_valid
    end

    it "should destroy the report" do
      @report.delete
      expect(Report.find_by(title:"Un trou dans la route")).to eq(nil)
    end

    describe "test update report" do
      it "shouldn't be update" do
        @report.update(content:"")
        expect(@report).not_to be_valid
      end 

      it "should be update" do
        @report.update(content:"Et donc là il y a un trou dans la route à l'impasse John Doe")
        expect(@report).to be_valid
      end
    end
  end

  context "association" do

    it "should find the nickname of the creator's report" do
      expect(@report.user.nickname).to eq("John")
    end
  end
end
