require 'sequel'
require 'pg'
require 'mysql'
require 'json'
require 'csv'

path = ENV["SDS_OUTPUT_PATH"]
options_str = ENV["SDS_PLUGIN_CONFIG_JSON"]
options = JSON.parse(options_str)
db_opts = options["database"].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
io_opts = options["io"].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

# database
sql_command      = db_opts[:sql]
driver           = db_opts[:adapter]
user             = db_opts[:user]
password         = db_opts[:password]
host             = db_opts[:host]
port             = db_opts[:port]
database_name    = db_opts[:databaseName]


# io
quote_char = io_opts[:quoteChar]
delim_char = io_opts[:delimiter]
headers = io_opts[:headers]
quote_strategy = io_opts[:quoteStrategy]

uri = "#{driver}://#{user}:#{password}@#{host}:#{port}/#{database_name}"

DB = Sequel.connect(uri)
data = DB[sql_command]

CSV.open(path, 'wb', {
    col_sep: delim_char,
    quote_char: quote_char
  }) do |csv|
  first = true
  data.each do |row|
    csv << row.inject([]) { |r, n| r << n[0] } and first = false if first
    csv << row.inject([]) { |r, n| r << n[1] }
  end
end

