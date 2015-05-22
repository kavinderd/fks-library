class Book < ActiveRecord::Base
  validates_presence_of :title,:author,:language
  belongs_to :collection, inverse_of: :books
  has_many :checkouts, inverse_of: :book
  belongs_to :author, inverse_of: :books

  enum category: [ 
    :blank_category,
    :children,
    :cultural,
    :gurbani,
    :history,
    :geography,
    :literature,
    :reference
  ]

  enum sub_category: [
    :blank_sub_category,
    :biography,
    :janam_sakhi,
    :fiction,
    :primer,
    :psb_syllabus,
    :gurdwaras,
    :language_and_grammar,
    :sikh_comics,
    :sikh_motivational,
    :traditional_stories,
    :dictionary,
    :legal,
    :steek_and_teeka,
    :sikh_history,
    :mughal_history,
    :british_history,
    :world_history,
    :gurvichaar,
    :paath,
    :folk_tales,
    :syllabus,
    :comedy,
    :sports,
    :gatka,
    :festivals,
    :riddles,
    :bhagats,
    :traditions,
    :social,
    :poetry
  ]

  enum level: [
    :blank_level,
    :pre_k,
    :elementary,
    :middle,
    :high,
    :adult
  ]

  enum language: [
    :blank_language,
    :punjabi,
    :urdu,
    :pharsi,
    :english,
    :bilingual
  ]



  after_create :generate_code

  def generate_code
    self.code = "#{self.collection.public_id}.#{Book.categories[self.category]}.#{Book.sub_categories[self.sub_category]}.#{Book.levels[self.level]}.#{Book.languages[self.language]}.#{self.public_id}.#{self.copy_number}"
    self.save!
  end

  rails_admin do

    edit do
      field :title
      field :author
      field :description
      field :language, :enum do
        enum do 
          Book.languages.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
      field :level, :enum do
        enum do
          Book.levelss.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
      field :category, :enum do
        enum do
          Book.categories.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
      field :sub_category, :enum do
        enum do
          Book.categories.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
    end
  end


end
