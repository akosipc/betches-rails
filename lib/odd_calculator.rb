class Participant
  attr_accessor :name, :seed, :odds

  class << self
    def for(item, index = nil)
      case item.class.to_s
        when "String"
          new(name: item, seed: index)
        when "Hash"
          new(name: item[:name], seed: item[:seed])
      end
    end
  end

  def initialize(name:, seed: 0, options: {})
    @name = name
    @seed = seed
    @options = options
  end
end

class OddCalculator
  attr_reader :collection, :options

  def initialize(collection, options = {})
    @collection = collection
    @options = options
  end

  def calculate
    @collection.map.with_index do |item, index|
      p = Participant.for(item, index)
      p.odds = @collection.length.to_f

      p
    end
  end
end
