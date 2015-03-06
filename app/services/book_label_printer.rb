require 'prawn'

class BookLabelPrinter 

  def initialize
  end

  def print_all_labels
    Prawn::Document.generate("book_labels.pdf") do |pdf|

      start = 725
      x = 0
      i = 0
      Book.find_each do |book|
        uid = Digest::SHA1.hexdigest(book.title).chars.inject(0) { |result, char| result += char.to_i }
        pdf.start_new_page and start = 725 if start < 120
        pdf.bounding_box([x,start], width: 275, height: 150) do
          pdf.transparent(0.5) {pdf.dash(1);  pdf.stroke_bounds; pdf.undash;}
          pdf.move_down 15
          pdf.text "<b>Fremont Khalsa School Library</b>", align: :center, size: 14, inline_format: true
          pdf.move_down 10
          pdf.text "Book ID: #{book.code}", align: :left, indent_paragraphs: 10, size: 10
          pdf.draw_text "Copy #: #{book.copy_number}", at: [ 210, 100], size: 10
          pdf.move_down 6
          pdf.text "Category: #{book.category}", align: :left, indent_paragraphs: 10, size: 10
          pdf.move_down 6
          pdf.text "Author: #{book.author.name}" , size: 12, indent_paragraphs: 10, inline_format: true
          pdf.move_down 6
          pdf.text "Title: #{book.title}", size: 12, indent_paragraphs: 10, inline_format: true
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

