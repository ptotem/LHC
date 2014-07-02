class DomainName < ActiveRecord::Base


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then
        Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then
        Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then
        Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      puts spreadsheet.row(i)[3]
      @d = DomainName.where(:name => spreadsheet.row(i)[3]).first
      if !@d.nil?
        @d.institute_name = "#{spreadsheet.row(i)[1]}, #{spreadsheet.row(i)[2]}"
        @d.save
      end
    end
  end
end
