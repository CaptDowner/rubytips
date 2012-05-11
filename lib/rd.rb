$LOAD_PATH.unshift 'lib'

require 'pg'
require 'postgres'
require 'yaml'
require 'time'
#require 'activerecord'
require 'htmlentities'


class Tip # <  ActiveRecord::Base
  attr_accessor :tip, :source, :rubytype, :subject, :category, :firstname, :lastname, :email, :applies_to, :posted

  def initialize(args)

    @source     = args[:source] || "ruby-talk"
    @rubytype      = args[:rubytype]  || "TBD"
    @subject    = args[:subject] || ""
    @category   = args[:category] || "TBD"
    @tip        = args[:tip] || ""
    @applies_to = args[:applies_to] || "1.9.3"
    @email      = args[:email] || ""
    @posted     = args[:posted] || ""
    @firstname  = args[:first] || ""
    @lastname   = args[:last] || ""
  end

  def to_s
    puts "source = #{@source}\nrubytype = #{@rubytype}\ncategory = #{@category}\nfirstname = #{@firstname}\nlastname = #{@lastname}\nemail = #{@email}\napplies_to = #{@applies_to}\nposted = #{@posted}\ntip = #{@tip}"
  end

  def read(file)
    blank = false
    f = File.new(file,"r")
    f.readlines.each do |line|
      # do stuff with each line
      if blank
        # store message text until EOF
        if line
          if line.include?('"')
            @tip << line.gsub!(/\"/,"&quot;")
          elsif line.include?("'")
            @tip << line.gsub!(/\'/,"&apos;")        
          else  
            @tip << line
          end
        end
      else
        if line.start_with?("\n")
          blank = true
        end
        if line.start_with?("From: ")
          # parse name into first last and email fields
          line.rstrip!
          line = line[6..-1]
          arr = line.split
          if(arr.size == 3)
            @firstname = arr[0]
            @lastname = arr[1]
            arr[2].gsub!('<','')
            arr[2].gsub!('>','')
            @email = arr[2]
          elsif(arr.size == 2)
            arr[0] = @lastname
            if arr[1].include?('<')
              arr[1].gsub!('<','')
              arr[1].gsub!('>','')
            end
            @email = arr[1]
          else
            @email = arr[0]
          end
        end
        if line.start_with?("Posted: ")
           line.rstrip!
           @posted = line[8..-1]
        end
        if line.start_with?("X-ML-Name: ")
           line.rstrip!
           @source = line[11..-1]
        end
        if line.start_with?("Subject: ")
           line.rstrip!
           @subject = line[9..-1]
        end
      end
    end
    @tip.rstrip!
    coder = HTMLEntities.new          
    @tip = coder.encode(@tip)
    
=begin    
#---------------------------------------------------------------------------------
# Be sure to insert this CSS into every page that displays the *tip* source codes
#---------------------------------------------------------------------------------
<head>
  <style type="text/css">
  code { white-space: pre; }
  </style>
</head>
#---------------------------------------------------------------------------------
=end
    # add html "<code>" tag for source example codes
    @tip = "&lt;code&gt;" + @tip + "&lt;/code&gt;"
#   remember to close the file after this method returns
    if @email.include?('<')
       @email.gsub!('<','')
    end
    if @email.include?('>')    
       @email.gsub!('>','')
    end
#    self.to_s
  end

  def db_write(con)
#    puts @source + '\n' + @rubytype + '\n' + @subject + '\n' + @category + '\n' +  @applies_to + '\n' + @firstname + '\n' + @lastname + '\n' + @email + '\n' + @posted
    q = "insert into \"tips\"(source,rubytype,subject,category,applies_to,email,firstname,lastname,posted,created_at,updated_at,tip) values('" + @source + "','" + @rubytype + "','" + @subject + "','" + @category +  "','" + @applies_to + "','" + @email + "','" + @firstname + "','" + @lastname + "','" + @posted + "'" + "::timestamp," + "NOW(), NOW()" + ",'" + @tip + "')" 
#    + ",'" + @tip + ')"'
    puts "Connected to #{con.db} at #{con.host}"      
#    puts q
    con.exec(q)
  end
end

def connect(db, user, pw)
  PGconn::new('localhost', 5432, '', '', db, user, pw) 
end

conn = PGconn.connect('localhost',5432,'','','tips_dev','captdowner','sailing')

mytips = Array.new
Dir.chdir("/home/sdownie/S.D/Ruby\ Tips/redo")
filearray = Dir.glob('*')
filearray.each do |f|
  t = Tip.new({}) 

  
  t.read(f)
  puts "Read filename = #{f}"
  t.db_write(conn)  
  puts "DB write filename = #{f}"  
  mytips << t
end
conn.close if conn

#puts "mytips.size = #{mytips.size}"
#count = 0
#ytips.each do |t|
#  t.to_s
#  0.upto(2) do |x|
#  puts "inside mytips array..."
#  puts t.to_s
#  con = Mysql2::Client.new(:host => 'localhost',:user => 'sdownie',:password => 'sailing',:database => 'tips_dev')
#  con.query('insert into tips(source,rubytype,subject,category,applies_to,firstname,lastname,email,posted,updated_at,created_at) values("ruby-tips","myarray","Interesting Stuff","modifying arrays","1.9.1","Roger","Rabbit","roger@bunnies.net",187654,NOW(),NOW())')
# conn = PGconn.connect('localhost',5432,'','','tips_dev','captdowner','sailing')
# t.db_write(conn)
# conn.close if conn
#end
