require 'csv'
require 'pry'

table = 'estabelecimento'

CSV.parse(File.read("#{table}.csv"), headers: true) do |row|
  values = row.fields.map { |f| "'#{f}'" }.join(',')
  puts "insert into #{table}(#{row.headers.join(',')}) values(#{values});"
end
