# sinatra-template

Simple boilerplate using Sinatra to build APIs that includes ActiveRecord (with PG), Migrations and Rspec.


## Starting

### Dependencies

    bundle install

### Database

Change the *config/database.yml* and sets your username:

    defaults: &defaults
      adapter: postgresql
      encoding: unicode
      host: localhost
      username: pg_username
      password:
      pool: 5

    development:
      database: sinatra_development
      <<: *defaults

    test:
      database: sinatra_test
      <<: *defaults

    production:
      database: sinatra_production
      <<: *defaults

### Migrations

Create a *Post* sample:

    rake db:create db:migrate db:seed


### Run the App

  ruby app.rb

And go to *http://localhost:4567/*

## Tests

I've added rspec for testing. So, you have to run the migration at RACK_ENV=test

        RACK_ENV=test rake db:create db:migrate
        
### Run the tests

        rspec
        
Then you should see something like:

    ..
    Finished in 0.04674 seconds (files took 0.71477 seconds to load)
    2 examples, 0 failures

**Have fun** :beer: