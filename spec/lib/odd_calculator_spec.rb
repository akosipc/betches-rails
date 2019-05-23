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
    context 'when the collection length is odd' do
      let!(:collection) { ['A', 'B', 'C', 'D', 'E'] }

      it 'calculate the odds based on the seed level that was given' do
        result = lib.calculate(:seeded_odds)

        expect(result).to be_instance_of Array

        expect(result[0]).to be_instance_of Participant
        expect(result[0].odds).to eq 30
        expect(result[1].odds).to eq 25
        expect(result[2].odds).to eq 20
        expect(result[3].odds).to eq 15
        expect(result[4].odds).to eq 10
      end
    end

    context 'when the collection length is even' do
      let!(:collection) { ['A', 'B', 'C', 'D', 'E', 'F'] }

      it 'calculate the odds based on the seed level that was given' do
        result = lib.calculate(:seeded_odds)

        expect(result).to be_instance_of Array
        expect(result.sum(&:odds).to_i).to eq 100

        expect(result[0].name).to eq 'A'
        expect(result[2].name).to eq 'C'
        expect(result[3].name).to eq 'D'
        expect(result[5].name).to eq 'F'
        expect(result[0].odds).to eq 25.0
        expect(result[2].odds).to eq 16.666666666666668
        expect(result[3].odds).to eq 16.666666666666668
        expect(result[5].odds).to eq 8.333333333333336
      end
    end

    context 'when the collection has more numbers' do
      let!(:collection) { ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'] }

      it 'calculates the odds' do
        result = lib.calculate(:seeded_odds)

        expect(result).to be_instance_of Array
        expect(result.sum(&:odds)).to eq 100

        expect(result[0].name).to eq 'A'
        expect(result[4].name).to eq 'E'
        expect(result[8].name).to eq 'I'
        expect(result[0].odds).to eq 16.666666666666668
        expect(result[4].odds).to eq 11.11111111111111
        expect(result[8].odds).to eq 5.555555555555555
      end
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
      let!(:collection) { [ {name: 'A', odds: 1}, {name: 'B', odds: 2}, {name: 'C', odds: 3}, {name: 'D', odds: 4} ] }

      it 'calculates the odds for each participant in decimal format based on the seeding allocation' do
        result = lib.calculate
        expect(result).to be_instance_of Array

        expect(result[0]).to be_instance_of Participant
        expect(result[0].name).to eq "A"
        expect(result[0].odds).to eq 1

        expect(result[3]).to be_instance_of Participant
        expect(result[3].name).to eq "D"
        expect(result[3].odds).to eq 4
      end
    end
  end
end
