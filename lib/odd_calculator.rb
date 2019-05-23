class Participant
  attr_accessor :name, :odds

  class << self
    def for(item, odds)
      case item.class.to_s
        when "String"
          new(name: item, odds: odds) when "Hash"
          new(name: item[:name], odds: item[:odds])
      end
    end
  end

  def initialize(name:, odds: 0, options: {})
    @name = name
    @odds = odds
    @options = options
  end
end

class OddCalculator
  attr_reader :collection, :options

  def initialize(collection, options = {})
    @collection = collection
    @options = options
  end

  def calculate(format = :even_odds)
    send(format)
  end

  private

  def even_odds
    @collection.map.with_index do |item, index|
      Participant.for(item, @collection.length.to_f)
    end
  end

  def seeded_odds
    median = 100 / @collection.length.to_f 
    divided_collection = @collection.each_slice((@collection.length / 2.0).round).to_a

    do_seeded_odds({
      collection: divided_collection[0].reverse,
      operation: "+",
      prev_odds: @collection.length % 2 == 0 ? median : 0,
      median: median,
      acc: []
    }).reverse + 
    do_seeded_odds({
      collection: divided_collection[1],
      operation: "-",
      prev_odds: @collection.length % 2 == 0 ? 0 : median,
      median: median,
      acc: []
    })
  end

  def do_seeded_odds(collection:, operation:, prev_odds:, median:, acc:)
    return acc if collection.empty?

    acc << Participant.for(collection.shift, prev_odds.zero? ? median : median.send(operation, (prev_odds / 2)))

    do_seeded_odds({
      collection: collection,
      operation: operation,
      prev_odds: acc.last.odds,
      median: median,
      acc: acc
    })
  end
end
