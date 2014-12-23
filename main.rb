require 'sequel'
require 'json'
require 'csv'

options_str = ENV["SDS_PLUGIN_CONFIG_JSON"]
options = JSON.parse(options_str)

sql              = options[:sql]
driver           = options[:adapter]
user             = options[:user]
password         = options[:password]
host             = options[:host]
port             = options[:port]
database_name    = options[:databaseName]
path =  = options[:path]

uri = "#{driver}://#{user}:#{password}@#{host}:#{port}/#{databaseName}"

DB = Sequel.connect(uri)
data = DB.run(sql)

CSV.open(path, 'wb') do |csv|
  first = true
  data.each do |row|
    csv << row.inject([]) { |r, n| r << n[0] } and first = false if first
    csv << row.inject([]) { |r, n| r << n[1] }
  end
end

