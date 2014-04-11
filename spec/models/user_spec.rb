require 'spec_helper'

describe "A user" do

  it "requires a firstname" do
    user = User.new(firstname: "")

    expect(user.valid?).to be_false
    expect(user.errors[:firstname].any?).to be_true
  end

 it "requires a lastname" do
    user = User.new(lastname: "")

    expect(user.valid?).to be_false
    expect(user.errors[:lastname].any?).to be_true
  end

  it "requires an email" do
    user = User.new(email: "")

    expect(user.valid?).to be_false
    expect(user.errors[:email].any?).to be_true
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)

      expect(user.valid?).to be_false
      expect(user.errors[:email].any?).to be_false
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = User.new(email: email)

      expect(user.valid?).to be_false
      expect(user.errors[:email].any?).to be_true
    end
  end

  it "requires a unique, case insensitive email address" do
    user1 = User.create!(user_attributes)

    user2 = User.new(email: user1.email.upcase)
    expect(user2.valid?).to be_false
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.new(user_attributes)

    expect(user.valid?).to be_true
  end

  it "requires a password" do
    user = User.new(password: "")

    expect(user.valid?).to be_false
    expect(user.errors[:password].any?).to be_true
  end

  it "requires a password confirmation when a password is present" do
    user = User.new(password: "secret", password_confirmation: "")

    expect(user.valid?).to be_false
    expect(user.errors[:password_confirmation].any?).to be_true
  end

  it "requires the password to match the password confirmation" do
    user = User.new(password: "secret", password_confirmation: "nomatch")

    expect(user.valid?).to be_false
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "requires a password and matching password confirmation when creating" do
    user = User.create!(user_attributes(password: "secret", password_confirmation: "secret"))

    expect(user.valid?).to be_true
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""

    expect(user.valid?).to be_true
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = User.new(password: "secret")

    expect(user.password_digest).to be_present
  end

  describe "authenticate" do
    before do
      @user = User.create!(user_attributes)
    end

    it "returns false if the email does not match" do
      expect(User.authenticate("nomatch", @user.password)).to be_false
    end

    it "returns false if the password does not match" do
      expect(User.authenticate(@user.email, "nomatch")).to be_false
    end

    it "returns the user if the email and password match" do
      expect(User.authenticate(@user.email, @user.password)).to eq(@user)
    end
  end
end
