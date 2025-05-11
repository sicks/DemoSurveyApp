# Demo Survey App

#### Prerequisites

1. `ruby -v` should return Ruby 3.3.0

    [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/) - I like [ruby-install](https://github.com/postmodern/ruby-install)/[chruby](https://github.com/postmodern/chruby)

2. `echo $BROWSER` should return the path to the executable for a chromium based browser.

    If it doesn't, add `export BROWSER=/usr/bin/google-chrome-stable` to your `~/.bashrc` (replace `google-chrome-stable` with the chromium based browser of your choice)

## Local Setup

1. Check out this repo and navigate into the folder

	`git clone git@github.com:sicks/DemoSurveyApp.git && cd DemoSurveyApp`

2. Install gems

	`bundle install`

3. Setup the database:

	`rails db:setup`

4. Start the server

	`bundle exec rails s`

5. Visit `http://localhost:3000`

## Running tests

Run `bundle exec rspec -fd` to see the formatted output of the full test suite.
