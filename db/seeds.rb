 require 'pry'

 tips = [
  [5,'ruby-talk','Array','Is there a better way to check this array?','array,string,include?,any?,boolean,return','1.9.3','bill@test.com','2011-12-03 12:39:00','2012-05-02 11:37:03.037929','2012-07-28 19:19:11.458392','000000', \
  '> As I see it now I can\'t do a simple include?\r> ruby-1.9.2-p290 :021 > names.include?(\'fred\')\r>  => false\r\rHow about \'any?\', where you can use your own comparison block:\r\r> names.any? {|i| i.include?(\"fred\")}\r=> true\r> names.any? {|i| i.include?(\"fred\")}\r=> false\r\rFrom Ammar Ali:\r\rFYI, you can use variables inside the regular expression.\r\r>> name = \"fred\"\r=> \"fred\"\r>> names.grep /#{name}/i\r=> [\"fred,9\"]',3], 
  [3,'ruby-talk','Class','Do you nest classes inside classes?','class,namespace,nest,nested,contain,names,namespaces,private','1.9.3','bill@test.com','2009-05-25 09:47:00','2012-05-02 11:37:02.95603','2012-05-11 18:02:02.323436','000000', \
  '>> Generally I think using nested classes for real helper classes that can conceptually only \r>> be for use with the parent class is a useful way of avoiding namespace clutter.\r\r> This is the only really good reason I\'ve found for doing so.\r\rI can\'t agree with that, the value of namespaces is orthogonal to\rideas like \'private\' classes, in fact, I think it\'s more valuable when\rthe names are intended to be used outside of the implementation of a\rclass, it helps whenever two things end up competing for a name.\r\rFor example in my new icalendar gem, I use nested name spacing so that\rI can have an Event class, and a using application can have it\'s own\rEvent class(es), maybe one might be a database model.\r\rI\'ve seen, and been involved with too many languages which suffered\rfrom the lack of Namespaces, sometimes adding them in later versions\rof the language, not to appreciate the value.\r\rIt really isn\'t an issue of containing a class within a class, it\'s an\rissue of containing names within name spaces.\r\rAnd I do other things like putting a module which I\'ve used to\rrefactor a large class into separate files inside the namespace of the\r(main or only) class which includes it.\r\r<a href=\'http://github.com/rubyredrick/ri_cal/tree/master\'>http://github.com/rubyredrick/ri_cal/tree/master</a>',3], 
  [2,'ruby-talk','Regexp','Scan - variable as pattern','regex,variable,pass,scan,instance,match','1.9.3','captdowner@gmail.com','2011-12-26 19:20:00','2012-05-02 11:37:02.912749','2012-05-11 18:00:59.777037','000000', \
  '> The docs for rRegexp (<a href=\'http://www.ruby-doc.org/core-1.9.3/Regexp.html\'>http://www.ruby-doc.org/core-1.9.3/Regexp.html</a>)\r> have a example\r> you need str.scan /#{s}/\r\rI\'d prefer to pass a Regexp instance directly in the variable:\r\r# any of these will do\rr = /./\rr = Regexp.new \'.\'\rr = /#{s}/\r\rstr.scan r do |match|\r...\rend',134], 
  [7,'ruby-talk','System','Multiple commands in shell','system,command,multiple,shell,run,+,script','1.9.3','captdowner@gmail.com','2009-01-07 23:18:00','2012-05-02 11:37:03.155751','2012-05-11 16:48:00.995869','000000', \
  '> Thanks I have it working now. I have one other question, why doesn\'t\r> ruby openssl support counter mode of operation?\r\rRuby\'s Cipher class supports whatever OpenSSL\'s EVP_CIPHER interface\rsupports. Unfortunately, CTR mode never made it there until just recently.\rNow finally, 1.0.1 supports AES in CTR mode. If you are interested in using\rit, you may want to upgrade to 1.0.1 and then you can also use it from Ruby\rlike this:\r\rcipher = OpenSSL::Cipher.new(\'aes-128-ctr\')\r...',134],
  [4,'ruby-talk','OpenSSL','Ruby openssl ECC help','openssl,cypher,class,support,aes-128-ctr','1.9.3','ss@test.com','2012-03-31 14:52:00','2012-05-02 11:37:02.999213','2012-05-05 19:33:24.805984','000000', \
  '>> I\'m trying to run multiple commands in the shell from ruby but I can\'t\r>> seem to grasp how I keep the \'state\" from the previous shell command.\r>>\r>> For example, how would I perform the following sequence of commands in\r>> ruby:\r>>\r>> 1. cd /dir\r>> 2. ls\r>>\r>> Not counting \"ls /dir\" that is ;)\r>>\r>> I\'ve tried using:\r>>\r>> system \"cd /dir\"\r>> system \"ls\"\r>>\r>> .but it doesn\'t work.\r\r> $ pwd\r> /Users/dusty\r> [dusty@dustylaptop:~] $ ls tmp/\r> test.txt\r> \r> irb(main):003:0> system(\'pwd; cd tmp; ls\')\r> /Users/dusty\r> test.txt\r> => true\r\rHere\'s another way to do it using a here document by having multiple \rcommands on separate lines - much the same way as in a shell script:\r\r$ ruby /tmp/x.rb\r+ pwd\r/cygdrive/c/Dokumente und Einstellungen/robert\r+ cd /tmp\r+ pwd\r/tmp\r+ ls\rx.rb\r\r$ cat /tmp/x.rb\r\rsystem <<EOC\rset -x\rpwd\rcd /tmp\rpwd\rls\rEOC',9],
  [8,'ruby-talk','Book','OO style tutorials','book,recommend,object,oriented,construction,bertrand meyer,oo,design','1.9.3','rj@test.com','2009-03-08 14:33:00','2012-05-02 11:37:03.195562','2013-02-21 19:07:39.821211','000000', \
  '> I should also declare that I\'m a pretty lousy programmer, and \r> throughout Uni I had difficulty understanding the need for UML[1], \r> CRC[2], Design Patterns and various other OO design jargon.  But \r> after 8 odd years working in the commercial world they began to find \r> their place in my world.  The understanding I came to is that there \r> isn\'t a perfect tutorial for everyone because it depends a lot on \r> your experience.  Stuff that made no sense to me 8 years ago (and \r> indeed seemed overwhelmingly complicated) makes perfect sense today.\r\rTook me some time, too.  My first OO program was horrible and I believe \rit took at least a year until I managed to grasp it - at least half way.\r\r> That said I quite like CRC as a simple tool to help you think along \r> the right lines.\r\rI also believe that CRC is a good tool because it is quite simple and \rkeeps you focused on important points.  I\'d say though that it still \rtakes a bit more to craft a good OO application.  But CRC is very useful \ras it will also help to not lump too much functionality into a single class.\r\r> I suspect beyond that you probably want a good UML or Design Patterns \r> book.  I don\'t have any recommendations but hopefully someone else on \r> this thread will. :)\r\rI always recommend \"Object Oriented Software Construction\" by Bertrand \rMeyer.  It is not exactly a tutorial but rather an encyclopedia where \ryou can look up whatever OO term you encounter somewhere else.  Meyer \rreally has a profound understanding of all the different aspects of OO \rand ways in which it can be used.\r\r<a href=\"http://archive.eiffel.com/doc/oosc/page.html\">http://archive.eiffel.com/doc/oosc/page.html</a>',12],
  [6,'ruby-talk','Hash','Convert an array to a hash','array,hash,convert,assign','1.9.3','rocky@test.com','2009-12-05 06:21:00','2012-05-02 11:37:03.087463','2012-05-03 23:08:05.381456','000000', \
  'irb(main):001:0> a=[\"a\", \"hello\", \"b\", \"world\", \"c\", \"welcome\", \"d\", \r\"baby\"]\r=> [\"a\", \"hello\", \"b\", \"world\", \"c\", \"welcome\", \"d\", \"baby\"]\rirb(main):002:0> Hash[*a]\r=> {\"a\"=>\"hello\", \"b\"=>\"world\", \"c\"=>\"welcome\", \"d\"=>\"baby\"}\rirb(main):003:0>',133]
  ]

tips.each do |t|
  Tip.create([{
          :id => t[0],
      :source => t[1],
    :rubytype => t[2],
     :subject => t[3],
    :category => t[4],
  :applies_to => t[5],
       :email => t[6],
      :posted => t[7],
  :created_at => t[8],
  :updated_at => t[9],
       :xmail => t[10],
       :tip   => t[11],
     :user_id => t[12]
     }])
end

=begin
users = [ [  3,'Bill',    'Bradley', 'bill@test.com',          '$2a$10$ifPUScaPy51IOzHZUu0wXO4yApMHNhCCuQ.FIDki2OkFA3cnaTD12','2014-04-08 15:34:08.36782',  '2014-04-08 15:34:08.36782',  '0' ],
          [  4,'Tom',     'Jonees',  'tom@test.com',           '$2a$10$JvvoQJZILrqvwINI/BKO8u62zVnqUD0.U7PeWAemCAinHDbYbvRcO','2014-04-08 15:52:38.953428', '2014-04-09 17:22:08.819949', '0' ],
          [  6,'Bo',      'Didley',  'bo@test.com',            '$2a$10$d0SNRjHY7Of5zLCOvoedde367JF4BlnpaBx4htysoRuzjYvficSYC','2014-04-09 00:05:26.260742', '2014-04-09 00:05:26.260742', '0' ],
          [  8,'Tim',     'Pants',   'tp@test.com',            '$2a$10$8cycJp918HZ0FzsTC451WOWsg2G1MaEvRtgNP/SrhD3MDGc5tfuwa','2014-04-09 16:32:18.673422', '2014-04-09 16:32:18.673422', '0' ],
          [  9,'Sue',     'Slaven',  'ss@test.com',            '$2a$10$GdUskssmEwLXQOR7xIfMFuUyFVEJ7no.VGNAv5pRO6SK7wkB2hXMu','2014-04-09 17:01:23.660117', '2014-04-09 17:01:23.660117', '0' ],
          [ 12,'Rich',    'Jerant',  'rj@test.com',            '$2a$10$GEBegy2HEXqA5wO4i8k.oe99RHCX.yfS1KMXPhwHZDqLylhll6C9y','2014-04-09 17:11:41.477372', '2014-04-09 17:11:41.477372', '0' ],
          [ 44,'Captain', 'Downer',  'captdowner@gmail.com',   '$2a$10$cXRo/GsJzprIzwkwaWbRCO72R.h58QmbgVS6JgY/KO8sqn93wdguW','2014-04-10 18:31:33.29519',  '2014-04-10 18:31:33.29519',  '1' ],
          [ 88,'Sally',   'Ride',    'sride@nasa.gov',         '$2a$10$q/y74Ujbvcggr7nSQT8gi.QA/khCFGZkxEMEE8lssy1lJq69BZ3Vq','2014-04-10 20:51:40.072911', '2014-04-10 20:51:40.072911', '0' ],
          [133,'Rocky',   'Balboa',  'rocky@test.net',         '$2a$10$WqXXNaxagqJ1oaZa8zvR9.N2zanDYbrwdw.idIMsNETwHg.0OEuha','2014-04-10 21:45:08.261704', '2014-04-10 21:45:08.261704', '0' ],
          [134,'Captain', 'Downer',  'captdowner@comcast.net', '$2a$10$RTdr1f3OBlg6/L.5QUQbSez0ddx5A2X3nAIsuS4OkuxjLMc4ACqE2','2014-04-10 22:38:35.20717',  '2014-04-10 22:38:35.20717',  '1' ]
]

users.each do |u|
  User.create([{
             :id => u[0],
      :firstname => u[1],
       :lastname => u[2],
          :email => u[3],
:password_digest => u[4],
     :created_at => u[5],
     :updated_at => u[6],
          :admin => u[7]  }])
end

=end
