class Checkout < ActiveRecord::Base
  validates_presence_of :due_date, :book, :member
  enum status: [ :active, :overdue, :returned]

  belongs_to :book, inverse_of: :checkouts
  belongs_to :member, inverse_of: :checkouts
  before_create :set_status

  def set_status
    unless self.status
      self.status = :active
    end
  end

  rails_admin do
    edit do
      field :book
      field :member
      field :due_date
      field :status, :enum do
        enum do 
          Checkout.statuses.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
    end
  end

end
