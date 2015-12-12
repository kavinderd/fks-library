class BookFixer

  # This is for fixing the issue where duplicate copies of the same book were
  # allocated different public id. This function takes the lowest value public id
  # for each set of duplicates and assigns it to all the books.
  def self.consoldiate_duplicate_public_ids
    #SLOW OP
    books = Book.all
    grouped_books = Hash.new {|hash, key| hash[key] = [] }
    books.each { |book| grouped_books["#{book.title}-#{book.language}"] << book }
    deleted_titles = []
    grouped_books = grouped_books.select { |title, books| books.count > 1 }
    messages = []
    grouped_books.each do |key, title_set|
      sorted = title_set.sort {|x,y| x.public_id <=> y.public_id }
      new_id = sorted[0].public_id
      sorted.each do |book|
        old_code = book.code
        str = "#{book.title},#{book.language},#{book.code}"
        book.public_id = new_id
        book.save!
        book.generate_code
        if Book.where(code: book.code).count > 1
          puts "----------------DUPLICATE BOOK CODE FOUND --------------------"
        end
        str += ",#{book.code}"
        messages << str
      end
    end
    puts messages
  end
end


