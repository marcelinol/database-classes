require 'csv'
require 'pry'

def parse_file(file_name, table_name = nil)
  table_name ||= file_name.chomp('.csv')

  CSV.parse(File.read("#{file_name}"), headers: true) do |row|
    values = row.fields.map { |f| "'#{f}'" }.join(',')
    puts "insert into #{table_name}(#{row.headers.join(',')}) values(#{values});"
  end
end


files = Dir.entries('.').map { |file| file if file.match(/\.csv/) }.compact!

files.each { |file| parse_file(file) }
