require 'rails_helper'

RSpec.describe Book, :type => :model do

  context 'persistence' do
    
    it "creates a record with valid attributes" do
      expect do
        Book.create!(title: 'Book', author: 'Test Author', description: 'A Test Book', language: 'English')
      end.to change(Book, :count).by(1)
    end

    it "does not create an invalid record" do
      expect do
        Book.create(author:'Test Author', description: 'A Test Book')
      end.to_not change(Book, :count)
    end
  end

end
