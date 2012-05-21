rubytips
========

Ruby on Rails app displaying the best tips from the RubyTalk email list.

## Installation

RubyTips is a Ruby on Rails 3.2 application which runs on Ruby 1.9.3 and
[PostgreSQL](http://www.postgresql.org) databases.

### Setting Up a Development Copy: Step by Step

To install a development version of RubyTips, follow these steps:

1. Fork our GitHub repository: <https://github.com/CaptDowner/rubytips>
2. Clone the fork to your computer
3. If you don't already have bundler installed, get it by running `gem install bundler`
4. Run `bundle install` to install all of the project's dependencies
5. Finally, run `rake setup` to create the required config files, create the database, and seed it with data

To make things even easier, you can copy and paste this into your terminal once you've got the project cloned to your computer

```bash
gem install bundler
bundle install
bundle exec rake setup
```

## License

GPL v2. See `LICENCE` file for more details.
