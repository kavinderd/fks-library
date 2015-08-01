require 'roo'

class MemberImport
  
  attr_reader :rejects
  def initialize(file)
    @file = file
    @rejects = []
  end

  def import
    spreadsheet =  open_spreadsheet
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

  
  def open_spreadsheet
    case File.extname(@file.original_filename)
    when '.xls' then Roo::Excel.new(@file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(@file.path, nil, :ignore)
    else raise "Unknown file type: #{@file.original_filename}"
    end
  end
end
