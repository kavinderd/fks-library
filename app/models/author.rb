class Author < ActiveRecord::Base
  validates_presence_of :name
  has_many :books, inverse_of: :author

end
