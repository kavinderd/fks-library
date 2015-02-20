class Member < ActiveRecord::Base
  validates_presence_of :name, :email
  has_many :checkouts, inverse_of: :member

  after_create :generate_code

  def generate_code
    self.code = SecureRandom.hex(4)
    self.save!
  end

  rails_admin do
    configure :code do
      label "Leave Blank!"
    end
    edit do 
      field :name
      field :email
      field :student_number
      field :dob
      field :gender, :enum do
        enum do
          ['Male', 'Female']
        end
      end
      field :phone_number
    end
  end

end
