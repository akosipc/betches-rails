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
    median_at = (@collection.length / 2.0).round
    median = 100 / @collection.length.to_f 
    divided_collection = @collection.each_slice(median_at).to_a

    do_seeded_odds({
      start_at_median: divided_collection[0].length.odd?,
      incrementor: incrementor(median, median_at),
      collection: divided_collection[0].reverse,
      operation: "+",
      median: median,
      acc: []
    }).reverse + do_seeded_odds({
      start_at_median: divided_collection[1].length.odd?,
      incrementor: incrementor(median, median_at),
      collection: divided_collection[1],
      operation: "-",
      median: median,
      acc: []
    })
  end

  def do_seeded_odds(start_at_median: false, incrementor:, collection:, operation:, median:, acc:)
    return acc if collection.empty?

    if start_at_median
      acc << Participant.for(collection.shift, median)
    else
      acc << Participant.for(collection.shift, median.send(operation, incrementor))
    end

    do_seeded_odds({
      incrementor: incrementor,
      collection: collection,
      operation: operation,
      median: acc[-1].odds,
      acc: acc
    })
  end

  def incrementor(median, divisor)
    top_value = median + (median / 2)
    (top_value - median) / (divisor - 1)
  end
end
