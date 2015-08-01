require 'prawn'

class MemberCardPrinter

  def intialize
  end
  
  def print_recently_created_members(time = 1.day.ago)
    Prawn::Document.generate("member_cards.pdf") do |pdf|
      start = 725
      x = 0
      i = 0
      members = Member.where("created_at > ?", time)
      members.each do |member|
        pdf.start_new_page and start = 725 if start < 120
        pdf.bounding_box([x,start], width: 270, height: 145) do
          pdf.stroke_bounds
          pdf.move_down 4
          pdf.image "#{Rails.root}/app/assets/images/logo.png", scale: 0.015, position: :center
          pdf.move_down 5
          pdf.text "Fremont Khalsa School Library", align: :center, size: 12
          pdf.move_down 5
          pdf.text "#{member.name}", size: 18, align: :center
          pdf.move_down 8
          pdf.text "Student ID #: #{member.student_number}", size: 10, align: :center
          pdf.move_down 5
          pdf.text "If found please return to Fremont Khalsa School Office", align: :center, size: 8
          pdf.move_down 5
          pdf.text "( officefks@gmail.com )", align: :center, size: 8
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

  def print_all
    Prawn::Document.generate("member_cards.pdf") do |pdf|
      start = 725
      x = 0
      i = 0
      members = Member.order("created_at asc")
      members.each do |member|
        pdf.start_new_page and start = 725 if start < 120
        pdf.bounding_box([x,start], width: 270, height: 145) do
          pdf.stroke_bounds
          pdf.move_down 4
          pdf.image "#{Rails.root}/app/assets/images/logo.png", scale: 0.015, position: :center
          pdf.move_down 5
          pdf.text "Fremont Khalsa School Library", align: :center, size: 12
          pdf.move_down 5
          pdf.text "#{member.name}", size: 18, align: :center
          pdf.move_down 8
          pdf.text "Student ID #: #{member.student_number}", size: 10, align: :center
          pdf.move_down 5
          pdf.text "If found please return to Fremont Khalsa School Office", align: :center, size: 8
          pdf.move_down 5
          pdf.text "( officefks@gmail.com )", align: :center, size: 8
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
