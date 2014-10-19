class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :description, :language
  belongs_to :collection, inverse_of: :books
end
