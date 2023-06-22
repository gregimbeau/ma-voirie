require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do 
    @user = User.create(id: 1, nickname: "John", email:"test@test.com", password:"password", password_confirmation: "password")
    @user2 = User.create(id: 2, nickname: "John2", email:"test2@test.com", password:"password2", password_confirmation: "password2")
    @report = Report.create(id: 1, title: "Un trou dans la route",content: "Et donc là il y a un trou dans la route à l'impasse Duchedca", address:"13 rue de la Gare", user_id: @user.id)
    @comment = Comment.create(id: 1, content: "Oui il faut réparer", user_id: @user2.id, report_id: @report.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@comment).to be_a(Comment)
      expect(@comment).to be_valid
    end

    it "should be destroyed" do
      @comment.destroy
      expect(Comment.find_by(id:1)).to eq(nil)
    end
  end
end