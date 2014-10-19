class Collection < ActiveRecord::Base
  validates_presence_of :name, :city
  has_many :books, inverse_of: :collection
end
