require 'rspec'
require 'stringio'
require_relative 'ranking'

describe Ranking do

  let(:input) {
    <<~DOC
      Lions 3, Snakes 3
      Tarantulas 1, FC Awesome 0
      Lions 1, FC Awesome 1
      Tarantulas 3, Snakes 1
      Lions 4, Grouches 0
    DOC
  }

  let(:games) { [
    { 'Lions'      => 3, 'Snakes'     => 3 },
    { 'Tarantulas' => 1, 'FC Awesome' => 0 },
    { 'Lions'      => 1, 'FC Awesome' => 1 },
    { 'Tarantulas' => 3, 'Snakes'     => 1 },
    { 'Lions'      => 4, 'Grouches'   => 0 }
  ] }

  let(:scores)   { {
    'FC Awesome' => 1,
    'Grouches'   => 0,
    'Lions'      => 5,
    'Snakes'     => 1,
    'Tarantulas' => 6,
  } }

  let(:ranks) { {
    'Tarantulas' => {:score=>6, :rank=>1},
    'Lions'      => {:score=>5, :rank=>2},
    'FC Awesome' => {:score=>1, :rank=>3},
    'Snakes'     => {:score=>1, :rank=>3},
    'Grouches'   => {:score=>0, :rank=>5},
  } }

  let(:output) {
    <<~DOC
      1. Tarantulas, 6 pts
      2. Lions, 5 pts
      3. FC Awesome, 1 pt
      3. Snakes, 1 pt
      5. Grouches, 0 pts
    DOC
  }

  describe Ranking::Parser do

    let(:parser) { described_class.new(StringIO.new(input)) }

    it 'should parse game data' do
      expect(parser.games).to eq(games)
    end

  end

  describe Ranking::Calculator do

    let(:calc) { described_class.new(games) }

    it 'should calculator team scores' do
      expect(calc.scores).to eq(scores)
    end

    it 'should calculate team rankings' do
      expect(calc.ranks).to eq(ranks)
    end

  end

  describe Ranking::Printer do

    let(:stream)  { StringIO.new }
    let(:printer) { described_class.new(stream) }

    it 'should format and print team rankings' do
      printer.print(ranks)
      stream.rewind
      expect(stream.read).to eq(output)
    end

  end

end
