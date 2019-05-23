## Betches

Betting Management Simplied.

#### Version

```
  Ruby 2.6.3
  Rails 5.2.3
  Postgres 10.4
```

#### Installation

```
$ git clone git@github.com:akosipc/shiny-octo-spoon.git
$ cd shiny-octo-spoon
```

#### Starting the application

```
$ bundle exec rails server
```

#### Database creation

```
$ rake db:create db:migrate db:test:prepare
```

#### How to run the test suite

```
$ rspec spec
```

#### Tasks before launching
- [ ] Architecture
  - [x] Betches
  - [x] Bettables
  - [ ] Bets
  - [ ] Users
- [ ] Features
  - [ ] Devise
  - [ ] Create a Betch
    - [ ] Import from Challonge Tournament
  - [ ] Create a Bettable
    - [x] Auto Calculate Odds
    - [ ] Convert Odds to Different Formats
  - [ ] Create a Bet
    - [ ] Stripe Processing
    - [ ] GWX Processing
