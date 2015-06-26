require 'prawn'

class BookLabelPrinter 

  def initialize
  end

  def print_recently_updated_books
    Prawn::Document.generate("book_labels.pdf") do |pdf|
      start = 725
      x = 0
      i = 0
      books = Book.where("updated_at > ?", 1.day.ago).order("created_at asc")
      books.each do |book|
        pdf.start_new_page and start = 725 if start < 120
        pdf.bounding_box([x,start], width: 280, height: 155) do
          pdf.transparent(0.5) {pdf.dash(1);  pdf.stroke_bounds; pdf.undash;}
          pdf.move_down 15
          pdf.text "<b>Fremont Khalsa School Library</b>", align: :center, size: 14, inline_format: true
          pdf.move_down 10
          pdf.text "<b>Book ID</b>: #{book.code}", align: :left, indent_paragraphs: 10, size: 16, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Category</b>: #{book.category.capitalize}", align: :left, indent_paragraphs: 10, size: 10, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Author</b>: #{book.author.name}" , size: 10, indent_paragraphs: 10, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Title</b>: #{book.title}", size: 10, indent_paragraphs: 10, inline_format: true
          pdf.move_down 5
          pdf.text "If found please return to Fremont Khalsa School Office", indent_paragraphs: 12, align: :center, size: 8
          pdf.move_down 5
          pdf.text "(officefks@gmail.com)", align: :center, size: 8
        end 
        if i % 2 != 0
          x += 280
        else
          start -= 155
          x = 0
        end
        i += 1
      end
    end
  end

  def print_all_labels
    Prawn::Document.generate("book_labels.pdf") do |pdf|
      start = 725
      x = 0
      i = 0
      books = Book.order("created_at asc")
      books.each do |book|
        pdf.start_new_page and start = 725 if start < 120
        pdf.bounding_box([x,start], width: 280, height: 155) do
          pdf.transparent(0.5) {pdf.dash(1);  pdf.stroke_bounds; pdf.undash;}
          pdf.move_down 15
          pdf.text "<b>Fremont Khalsa School Library</b>", align: :center, size: 14, inline_format: true
          pdf.move_down 10
          pdf.text "<b>Book ID</b>: #{book.code}", align: :left, indent_paragraphs: 10, size: 16, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Category</b>: #{book.category.capitalize}", align: :left, indent_paragraphs: 10, size: 10, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Author</b>: #{book.author.name}" , size: 10, indent_paragraphs: 10, inline_format: true
          pdf.move_down 6
          pdf.text "<b>Title</b>: #{book.title}", size: 10, indent_paragraphs: 10, inline_format: true
          pdf.move_down 5
          pdf.text "If found please return to Fremont Khalsa School Office", indent_paragraphs: 12, align: :center, size: 8
          pdf.move_down 5
          pdf.text "(officefks@gmail.com)", align: :center, size: 8
        end 
        if i % 2 != 0
          x += 280
        else
          start -= 155
          x = 0
        end
        i += 1
      end
    end
  end
end

