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
      create_member(row) unless Member.find_by(student_number: row["S No."])
      puts "Created student #{Name}"
    end
  end

  def create_member(row)
    begin 
      m = Member.new
      m.student_number = row["S. No."].strip.to_i
      m.name = row["Name"].strip
      m.dob = Date.parse(row["DOB"].strip) if row["DOB"]
      m.phone_number = row["Primary Phone Number"]
      m.email = row["Email"].strip if row["Email"]
      m.address = row["Address"]
      m.save!
    rescue Exception => e

    end
  end
end
