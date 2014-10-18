require 'rails_helper'

RSpec.describe Collection, :type => :model do

  context 'persistence' do
    
    it "creates a record for valid attributes" do
      expect do
        Collection.create(name: 'Test Collection', city: 'Harmondsworth')
      end.to change(Collection, :count).by(1)
    end

    it "does not create a record for invalid attributes" do
      expect do
        Collection.create(name: 'Test Collection')
      end.to_not change(Collection, :count)
    end

  end
end
