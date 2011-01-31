module Chainsaw
  class Import
    attr_accessor :file, :lines, :results, :skipped, :fields, :line_match
    
    class << self
      def rfield key
        FIELDS[key]
      end
    end
    
=begin
  %a - The abbreviated weekday name (``Sun'')
  %A - The  full  weekday  name (``Sunday'')
  %b - The abbreviated month name (``Jan'')
  %B - The  full  month  name (``January'')
  %c - The preferred local date and time representation
  %d - Day of the month (01..31)
  %H - Hour of the day, 24-hour clock (00..23)
  %I - Hour of the day, 12-hour clock (01..12)
  %j - Day of the year (001..366)
  %m - Month of the year (01..12)
  %M - Minute of the hour (00..59)
  %p - Meridian indicator (``AM''  or  ``PM'')
  %S - Second of the minute (00..60)
  %U - Week  number  of the current year,
          starting with the first Sunday as the first
          day of the first week (00..53)
  %W - Week  number  of the current year,
          starting with the first Monday as the first
          day of the first week (00..53)
  %w - Day of the week (Sunday is 0, 0..6)
  %x - Preferred representation for the date alone, no time
  %X - Preferred representation for the time alone, no date
  %y - Year without a century (00..99)
  %Y - Year with century
  %Z - Time zone name
  %% - Literal ``%'' character

=end
    
    DATE_FORMAT = '%d/%b/%Y:%H:%M:%S'
    # DATE_FORMAT = '10/Nov/2010:15:01:10 -0700'
    
    DEFAULT_FIELDS = {
      :ip => String,
      :user => String,
      :date => Time,
      :http_method => String,
      :path => String,
      :http_ver => String,
      :status => Integer,
      :bytes => Integer,
      :referrer => String
    }
    DEFAULT_LINE_MATCH = /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) - (.{0})- \[([^\]]+?)\] "(GET|POST|PUT|DELETE) ([^\s]+?) (HTTP\/1\.1)" (\d+) (\d+) "-" "(.*)"/
        
    def initialize file, db_name
      @file = file      # the file to process
      @lines = 0        # num lines encountered
      @processed = 0    # The processed lines (as matches)
      @skipped = 0      # The skipped lines (non-matched)
      @fields = DEFAULT_FIELDS
      @line_match = DEFAULT_LINE_MATCH
      @db = Connection.instance.connect(db_name)
    end
    
    def run
      raw = @db.collection('raw_import')
      IO.foreach(file) do |line|
      # File.open(file, 'r') do |f|
        # f.each_line do |line|
          @lines += 1
          match = line.match(@line_match)
          if match.nil?
            @skipped += 1
            puts '[SKIP] %s' % line
          else
            @processed += 1
            if @fields.size != match.captures.size
              puts 'Warning: unbalanced fields (%d) with matched line groups (%d). Results may be skewed.' % [@fields.size, match.captures.size]
              puts @fields.inspect
              puts match.captures.inspect
            end
            raw.insert(convert_match(match))
          end
        # end
      # end
        STDOUT.flush
      end
    end
    
    def stats
      %Q{
Import details:
  Imported file     = %s
  Found lines       = %d
  Processed lines   = %d
  Skipped lines     = %d
} % [
    @file,
    @lines,
    @processed,
    @skipped
  ]
    end
    
  private
  
    def convert_match match
      Hash.new.tap do |h|
        h[:raw] = match.string
        match.captures.each_with_index do |m, i|
          key = @fields.keys[i]
          h[key] = if @fields[key] == Integer
            m.to_s.to_i
          elsif @fields[key] ==  Time
            Time.strptime(m, DATE_FORMAT)
          else
            m.to_s
          end
        end
      end
    end
 
  end
end