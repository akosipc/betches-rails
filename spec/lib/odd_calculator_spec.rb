require 'rails_helper'
require 'odd_calculator'

RSpec.describe OddCalculator, type: :lib do
  let!(:collection) { [] }
  let!(:lib) { OddCalculator.new(collection) }

  describe '#calculate' do
    it 'calls the even_odds method by default' do
      expect(lib).to receive(:even_odds).and_return([])

      lib.calculate
    end

    it 'calls the seeded_odds when passed as an argument' do
      expect(lib).to receive(:seeded_odds).and_return([])

      lib.calculate(:seeded_odds)
    end

    it 'raises an NoMethodError when passed an invalid argument' do
      expect {
        lib.calculate(:uneven_odds)
      }.to raise_error(NoMethodError)
    end
  end

  describe '#seeded_odds' do
    let!(:collection) { ['A', 'B', 'C'] }

    it 'calculate the odds based on the seed level that was given' do
      result = lib.calculate(:seeded_odds)
      expect(result).to be_instance_of Array

      expect(result[0].name).to eq "A"
      expect(result[0].odds).to eq 

      expect(result[1].name).to eq "B"
      expect(result[1].odds).to eq 

      expect(result[2].name).to eq "C"
      expect(result[2].odds).to eq 
    end
  end

  describe '#even_odds' do
    context 'when a simple array was passed' do
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

    context 'when a collection was passed' do
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
end
