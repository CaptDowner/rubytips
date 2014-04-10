require 'spec_helper'

describe Tip do
#  pending "add some examples to (or delete) #{__FILE__}"

  it "requires a source" do
    tip = Tip.new(source: "")
    
    expect(tip.valid?).to be_false # populates errors
    expect(tip.errors[:source].any?).to be_true
  end
  
  it "requires a rubytype" do
    tip = Tip.new(rubytype: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:rubytype].any?).to be_true
  end
  
  it "requires a posted" do
    tip = Tip.new(posted: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:posted].any?).to be_true
  end
  
  it "requires a subject" do
    tip = Tip.new(subject: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:subject].any?).to be_true
  end
  
  it "requires a category" do
    tip = Tip.new(category: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:category].any?).to be_true
  end

  it "requires a applies to" do
    tip = Tip.new(applies_to: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:applies_to].any?).to be_true
  end

  it "requires an email" do
    tip = Tip.new(email: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:email].any?).to be_true
  end

  it "requires a firstname" do
    tip = Tip.new(firstname: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:firstname].any?).to be_true
  end

  it "requires a lastname" do
    tip = Tip.new(lastname: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:lastname].any?).to be_true
  end
  
  it "requires an xmail" do
    tip = Tip.new(xmail: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:xmail].any?).to be_true
  end

  it "requires a tip" do
    tip = Tip.new(tip: "")
    
    expect(tip.valid?).to be_false
    expect(tip.errors[:tip].any?).to be_true
  end

=begin


  it "accepts a $0 total gross" do
    tip = Tip.new(total_gross: 0.00)

    expect(tip.valid?).to be_false
    expect(tip.errors[:total_gross].any?).to be_false
  end
  
  it "accepts a positive total gross" do
    tip = Tip.new(total_gross: 10000000.00)

    expect(tip.valid?).to be_false
    expect(tip.errors[:total_gross].any?).to be_false
  end
  
  it "rejects a negative total gross" do
    tip = Tip.new(total_gross: -10000000.00)

    expect(tip.valid?).to be_false
    expect(tip.errors[:total_gross].any?).to be_true
  end
  
  it "accepts properly formatted image file names" do
    file_names = %w[e.png tip.png tip.jpg tip.gif tip.GIF]
    file_names.each do |file_name|
      tip = Tip.new(image_file_name: file_name)
      
      expect(tip.valid?).to be_false
      expect(tip.errors[:image_file_name].any?).to be_false
    end
  end
  
  it "rejects improperly formatted image file names" do
    file_names = %w[tip .jpg .png .gif tip.pdf tip.doc]
    file_names.each do |file_name|
      tip = Tip.new(image_file_name: file_name)
      
      expect(tip.valid?).to be_false
      expect(tip.errors[:image_file_name].any?).to be_true
    end
  end
  
  it "accepts any rating that is in an approved list" do
    ratings = %w[G PG PG-13 R NC-17]
    ratings.each do |rating|
      tip = Tip.new(rating: rating)
      
      expect(tip.valid?).to be_false
      expect(tip.errors[:rating].any?).to be_false
    end
  end
  
  it "rejects any rating that is not in the approved list" do
    ratings = %w[R-13 R-16 R-18 R-21]
    ratings.each do |rating|
      tip = Tip.new(rating: rating)
      
      expect(tip.valid?).to be_false
      expect(tip.errors[:rating].any?).to be_true
    end
  end
  
  it "is valid with example attributes" do
    tip = Tip.new(tip_attributes)
    
    expect(tip.valid?).to be_true
  end
  
  it "is a flop if the total gross is less than $50M" do
    tip = Tip.new(total_gross: 40000000)

    expect(tip).to be_flop
  end
  
  it "is not a flop if the total gross is greater than $50M" do
    tip = Tip.new(total_gross: 60000000)

    expect(tip).not_to be_flop
  end
  
  it "has many reviews" do
    tip = Tip.new(tip_attributes)

    review1 = tip.reviews.new(review_attributes)
    review2 = tip.reviews.new(review_attributes)

    expect(tip.reviews).to include(review1)
    expect(tip.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    tip = tip.create!(tip_attributes)

    tip.reviews.create!(review_attributes)

    expect { 
      tip.destroy
    }.to change(Review, :count).by(-1)
  end
  
  it "calculates the average number of review stars" do
    tip = tip.create!(tip_attributes)

    tip.reviews.create!(review_attributes(stars: 1))
    tip.reviews.create!(review_attributes(stars: 3))
    tip.reviews.create!(review_attributes(stars: 5))
    
    expect(tip.average_stars).to eq(3)
  end
 

  it "has fans" do
    tip = Tip.new(tip_attributes)
    fan1 = User.new(user_attributes(email: "larry@example.com"))
    fan2 = User.new(user_attributes(email: "moe@example.com"))

    tip.favorites.new(user: fan1)
    tip.favorites.new(user: fan2)

    expect(tip.fans).to include(fan1)
    expect(tip.fans).to include(fan2)
  end
  context "released query" do
    it "returns the tips with a released on date in the past" do
      tip = tip.create!(tip_attributes(released_on: 3.months.ago))

      expect(tip.released).to include(tip)
    end

    it "does not return tips with a released on date in the future" do
      tip = tip.create!(tip_attributes(released_on: 3.months.from_now))

      expect(tip.released).not_to include(tip)
    end

    it "returns released tips ordered with the most recently-released tip first" do
      tip1 = tip.create!(tip_attributes(released_on: 3.months.ago))
      tip2 = tip.create!(tip_attributes(released_on: 2.months.ago))
      tip3 = tip.create!(tip_attributes(released_on: 1.months.ago))

      expect(tip.released).to eq([tip3, tip2, tip1])
    end
  end

  context "hits query" do
    it "returns tips with a total gross of at least 300_000_000" do
      tip1 = tip.create!(tip_attributes(total_gross: 300_000_000))
      tip2 = tip.create!(tip_attributes(total_gross: 9_000_000))

      expect(tip.hits).to eq([tip1])
    end
  end

  context "flops query" do
    it "returns tips with a total gross less than 50_000_000" do
      tip1 = tip.create!(tip_attributes(total_gross: 300_000_000))
      tip2 = tip.create!(tip_attributes(total_gross: 49_000_000))

      expect(tip.flops).to eq([tip2])
    end
  end

  context "upcoming query" do
    it "returns the tips with a released on date in the future" do
      tip1 = tip.create(tip_attributes(released_on: 3.months.ago))
      tip2 = tip.create(tip_attributes(released_on: 3.months.from_now))

      expect(tip.upcoming).to eq([tip2])
    end
  end

  context "rated query" do
    it "returns released tips with the specified rating" do
      tip1 = tip.create(tip_attributes(released_on: 3.months.ago, rating: "PG"))
      tip2 = tip.create(tip_attributes(released_on: 3.months.ago, rating: "PG-13"))
      tip3 = tip.create(tip_attributes(released_on: 1.month.from_now, rating: "PG"))

      expect(tip.rated("PG")).to eq([tip1])
    end
  end

  it "generates a slug when it's created" do
    tip = tip.create!(tip_attributes(title: "X-Men: The Last Stand"))

    expect(tip.slug).to eq("x-men-the-last-stand")
  end

  it "requires a unique title" do
    tip1 = tip.create!(tip_attributes)

    tip2 = Tip.new(title: tip1.title)
    expect(tip2.valid?).to be_false
    expect(tip2.errors[:title].first).to eq("has already been taken")
  end

  it "requires a unique slug" do
    tip1 = tip.create!(tip_attributes)

    tip2 = Tip.new(slug: tip1.slug)
    expect(tip2.valid?).to be_false
    expect(tip2.errors[:slug].first).to eq("has already been taken")
  end
=end
end
