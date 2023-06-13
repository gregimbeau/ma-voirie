require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'return the full_name for a user' do
    user = User.create(first_name: "Philippe", last_name:"Popo");
    expect(user.full_name).to eq 'Philippe Popo'
  end


end
