require 'rails_helper'
require 'odd_calculator'

RSpec.describe OddCalculator, type: :lib do
  let!(:collection) { [] }
  let!(:lib) { OddCalculator.new(collection) }

  describe '#calculate' do
    let!(:collection)  { ['A', 'B', 'C', 'D'] }

    it 'calculates the odds for each participant in decimal format' do
      result = lib.calculate
      expect(result).to be_instance_of Array

      expect(result[0]).to be_instance_of Participant
      expect(result[0].name).to eq "A"
      expect(result[0].odds).to eq 4.00

      expect(result[3]).to be_instance_of Participant
      expect(result[3].name).to eq "D"
      expect(result[3].odds).to eq 4.00
    end
  end

  describe '#calculate' do
    let!(:collection) { [ {name: 'A', seed: 1}, {name: 'B', seed: 2}, {name: 'C', seed: 3}, {name: 'D', seed: 4} ] }

    it 'calculates the odds for each participant in decimal format based on the seeding allocation' do
      result = lib.calculate
      expect(result).to be_instance_of Array

      expect(result[0]).to be_instance_of Participant
      expect(result[0].name).to eq "A"
      expect(result[0].odds).to eq 4.00

      expect(result[3]).to be_instance_of Participant
      expect(result[3].name).to eq "D"
      expect(result[3].odds).to eq 4.00
    end
  end
end
