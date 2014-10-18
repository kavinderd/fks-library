require 'rails_helper'

RSpec.describe Member, :type => :model do
  
  context 'persistence' do

    it "creates a record with valid attributes" do
      expect do
        Member.create(name: 'First Last', email: 'test@gmail.com')
      end.to change(Member, :count).by(1)
    end

    it "does not create a record with invalid attributes" do
      expect do
        Member.create(email: 'test@gmail.com')
      end.to_not change(Member, :count)
    end
  end

end
