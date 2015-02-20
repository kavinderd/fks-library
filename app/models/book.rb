class Book < ActiveRecord::Base
  validates_presence_of :title,:author,:language
  belongs_to :collection, inverse_of: :books
  has_many :checkouts, inverse_of: :book
  belongs_to :author, inverse_of: :books

  enum language: [:punjabi, :english, :bilingual, :bilingual_punjabi, :bilingual_hindi, :bilingual_pbi]
  enum age_group: [:any,:prek, :elem, :middle, :high, :adult, :children, :pre_elem]
                 
  enum category: [:gurbani, :janam_sakhi, :sikh_history, :sikh_literature, :childrens_fiction, :fiction, :cultural, :comedy, :punjabi_language_and_grammar, :punjabi_primer, :psb_syllabus_books, :sikh_comics, :other_comics, :dictionary, :reference, :syllabus_books, :other_literature, :childrens, :general_punjabi]


  after_create :generate_code

  def generate_code
    uid = Digest::SHA1.hexdigest(self.title).chars.inject(0) { |result, char| result += char.to_i }
    self.code = "#{Book.languages[self.language]}.#{Book.age_groups[self.age_group]}.#{Book.categories[self.category]}.#{self.copy_number}.#{uid}"
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
      field :age_group, :enum do
        enum do
          Book.age_groups.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
      field :category, :enum do
        enum do
          Book.categories.map { |key, value| [key.gsub("_", " ").titleize, value] }
        end
      end
    end
  end


end
