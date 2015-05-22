class Checkout < ActiveRecord::Base
  validates_presence_of :due_date, :book, :member
  validate :book_available?
  validate :checkout_allowed?
  enum status: [ :active, :overdue, :returned]

  belongs_to :book, inverse_of: :checkouts
  belongs_to :member, inverse_of: :checkouts
  before_create :set_status

  def set_status
    unless self.status
      self.status = :active
    end
  end

  def status_enum
    Checkout.statuses.map { |key, value| [key.gsub("_", " ").titleize, value] }
  end

  def book_available?
    if self.book.checkouts.where(status: [0, 1]).any?
      errors.add(:book, "is currently checked-out")
    end
  end

  def checkout_allowed?
    if self.member.checkouts.where(status: [1]).any?
      errors.add(:member, "has an overdue Book")
    end
  end


  rails_admin do
    edit do
      field :book 
      field :member
      field :due_date
      field :status, :enum do
        enum do 
          Checkout.statuses.map { |key, value| [key.gsub("_", " ").titleize, key] }
        end
      end
    end
  end

end
