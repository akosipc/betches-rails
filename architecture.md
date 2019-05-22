Betch (like a tournament)
* name
* starts_at
* ends_at
* stake

- has_many :bettables

Bettable
* name
* description
* odds (decimal)
* type (string)
* seed (integer)
* rank (integer)

- has_many :bets

Bets
* amount

