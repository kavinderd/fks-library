class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :description, :language
end
