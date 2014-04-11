def tip_attributes(overrides = {})
  random_number = (0..9).to_a.shuffle[0..10].join
  {
    firstname: "Newtip",
    lastname: "Giver",
    source: "rubytalktips",
    rubytype: "Array",
    subject: "Method Missing",
    category: "tip,test,rspec,attributes",
    applies_to: "2.0.0/p247",
    posted: "2014-03-30 10:20:10",
    email: "rogerdodger@ballpark.net",
    xmail: "000000",
    tip: "This is the grestest Ruby Talk Tip ever!\nGoto: <a href='http://steve-downie.com'>Steve Downie</a>"
  }.merge(overrides)
end

#def review_attributes(overrides = {})
#  {
#    name: "Roger Ebert",
#    stars: 3,
#    comment: "I laughed, I cried, I spilled my popcorn!"
#  }.merge(overrides)
#end

def user_attributes(overrides = {})
  {
    firstname: "Example",
    lastname: "User",
    email: "user@example.com",
    password: "secret",
    password_confirmation: "secret"
  }.merge(overrides)
end
