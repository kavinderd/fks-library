require 'roo'

class BookImport

  attr_reader :rejects
  def initialize(file_location)
    @file = file_location 
    @rejects = []
    Author.connection
  end

  def update
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (1..spreadsheet.last_row).each do |r|
      row = Hash[[header, spreadsheet.row(r)].transpose]
      books = find_all_with_title(row["Title"])
      author = find_or_retrieve_author(row)
      count = row["# of Copies"].to_i
      books.each do |b|
        begin
          b.language = row["Language"].downcase.strip.gsub("-", "_") if row["Language"]
          b.level = get_level(row)
          b.category = row["Category"].strip.gsub(" ", "_").underscore if row["Category"]
          b.sub_category = row["Subcategory"].strip.gsub(" ", "_").underscore if row["Level"]
          b.author = author
          b.collection = default_collection
          b.public_id = generate_public_id(b)
          b.save!
          count -= 1
        rescue ArgumentError => e
          @rejects << [row, e.message]
        end
      end
      if count > 0
        row["# of Copies"] = count.to_s
        create_books(row, author)
      end

    end
  end

  def import
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (1..spreadsheet.last_row).each do |r|
      row = Hash[[header, spreadsheet.row(r)].transpose]
      author = find_or_retrieve_author(row)
      p row
      create_books(row, author)
      puts "Created #{row["Title"]}"
    end
    p "Rejected because #{@rejects.map { |item| item[1] }.uniq}"
  end

  def open_spreadsheet
    case File.extname(@file.original_filename)
    when '.xls' then Roo::Excel.new(@file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(@file.path, nil, :ignore)
    else raise "Unknown file type: #{@file.original_filename}"
    end
  end

  private

  def find_or_retrieve_author(row)
    Author.find_or_create_by(name:row["Author"].strip)
  end

  def find_all_with_title(title)
    Book.where(title: title)
  end

  def create_books(row, author)
    prev_num = nil
    if Book.where(title: row["Title"]).any?
      prev_num = Book.where(title: row["Title"]).order("copy_number desc").first.copy_number
    end
    public_id = nil
    (row["# of Copies"] || 1).to_i.times do |i|
      begin
        b = Book.new
        b.language = row["Language"].downcase.strip.gsub("-", "_") if row["Language"]
        b.level = get_level(row)
        b.category = row["Category"].strip.gsub(" ", "_").underscore if row["Category"]
        b.sub_category = row["Subcategory"].strip.gsub(" ", "_").underscore if row["Level"]
        b.title = row["Title"]
        if prev_num 
          b.copy_number = prev_num + 1
          prev_num += 1
        else
          b.copy_number = i + 1 
        end
        b.author = author
        b.collection = default_collection
        unless public_id
          public_id = generate_public_id(b)
        end
        b.public_id = public_id
        b.save
        puts "Saved"
      rescue ArgumentError => e
        @rejects << [row, e.message]
      end
    end
  end
  
  def get_level(row)
    level =  row["Level"].downcase.split("/").first.gsub("-", "").strip.gsub(" ","_") if row["Level"]
    level = "elementary" if level == "elem"
    level = "pre_k" if level == "prek"
    level
  end

  def default_collection
    @collection = Collection.first || initialize_collection 
  end

  def initialize_collection
    c = Collection.new
    c.name = "Fremont Gurdwara"
    c.city = "Fremont"
    c.public_id = 1
    c.save!
    c
  end

  def generate_public_id(book)
    previous = Book.where("collection_id = ?", book.collection_id)
    previous = previous.send(book.category)
    previous = previous.send(book.sub_category)
    previous = previous.send(book.level)
    previous = previous.send(book.language)
    previous = previous.order("public_id desc").first
    previous ? previous.public_id + 1 : 1
  end

  def self.generate_public_id(book)
    previous = Book.where("collection_id = ?", book.collection_id)
    previous = previous.send(book.category)
    previous = previous.send(book.sub_category)
    previous = previous.send(book.level)
    previous = previous.send(book.language)
    previous = previous.order("public_id desc").first
    previous ? previous.public_id + 1 : 1
  end
  

end
