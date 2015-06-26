require 'roo'

class MemberImport
  
  attr_reader :rejects
  def initialize(file)
    @file = file
    @rejects = []
  end

  def import
    spreadsheet = Roo::Excelx.new(@file)
    header = spreadsheet.row(1)
    (1..spreadsheet.last_row).each do |r|
      row = Hash[[header, spreadsheet.row(r)].transpose]
      p row
      create_member(row) unless Member.find_by(student_number: row["Student ID "].to_i)
      puts "Created student #{row["Name"]}"
    end
  end

  def create_member(row)
    begin 
      m = Member.new
      m.student_number = row["Student ID "].to_i
      m.name = row["Name "].strip
      m.email = row["Email"].strip if row["Email"]
      m.save!
    rescue Exception => e
      puts e
    end
  end
end
