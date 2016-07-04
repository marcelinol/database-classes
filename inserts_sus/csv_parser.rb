require 'csv'
require 'pry'

def parse_file(file_name)
  table_name ||= file_name.match(/[a-zA-Z].*/)[0].chomp('.csv')

  CSV.parse(File.read("#{file_name}"), headers: true) do |row|
    file = File.open('inserts.sql', 'a')
    values = row.fields.map { |f| "'#{f}'" }.join(',')
    file.puts "insert into #{table_name}(#{row.headers.join(',')}) values(#{values});"
  end
end


files = Dir.entries('.').map { |file| file if file.match(/\.csv/) }.compact!

files.sort.each { |file| parse_file(file) }
