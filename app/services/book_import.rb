require 'roo'

class BookImport

  attr_reader :rejects
  def initialize(file_location)
    @file = file_location 
    @rejects = []
    Author.connection
  end

  def import
    spreadsheet = Roo::Excelx.new(@file)
    header = spreadsheet.row(1)
    (1..spreadsheet.last_row).each do |r|
      row = Hash[[header, spreadsheet.row(r)].transpose]
      author = find_or_retrieve_author(row)
      p row
      create_books(row, author)
      puts "Created #{row["Title"]}"
    end
  end

  private

  def find_or_retrieve_author(row)
    Author.find_or_create_by(name:row["Author"].strip)
  end

  def create_books(row, author)
    prev_num = nil
    if Book.where(title: row["Title"]).any?
      prev_num = Book.where(title: row["Title"]).order("copy_number desc").first.copy_number
      puts "FOUND A PREVIOUS"
    end
    (row["Copy #"] || 1).to_i.times do |i|
      puts "ENTERING BOOK SAVING"
      begin
        b = Book.new
        b.language = row["Language"].downcase.strip.gsub("-", "_") if row["Language"]
        b.age_group = row["Age-Grp"].downcase.split("/").first.gsub("-", "").strip.gsub(" ","_") if row["Age-Grp"]
        b.category = row["Category"].strip.gsub(" ", "_").underscore if row["Category"]
        b.title = row["Title"]
        if prev_num 
          b.copy_number = prev_num + 1
          prev_num += 1
        else
          b.copy_number = i + 1 
        end
        b.author = author
        b.save
        puts "Saved"
      rescue ArgumentError => e
        @rejects << [row, e.message]
      end
    end
  end
end
