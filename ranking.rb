require 'thor'

class Ranking

  class Parser

    MATCHER = /((?<team1>.*)\s+(?<score1>\d+)),\s+((?<team2>.*)\s+(?<score2>\d+))/

    def initialize(stream)
      @data = stream.readlines
    end

    def games
      @games ||= \
        @data.map do |line|
          matches = line.match(MATCHER)

          { matches[:team1] => matches[:score1].to_i,
            matches[:team2] => matches[:score2].to_i }
        end
    end

  end


  class Calculator

    def initialize(games)
      @games = games
    end

    def ranks
      return @ranks if @ranks

      # teams must be sorted by descending score prior to ranking
      teams = scores.sort_by(&:last).reverse

      rank, last = nil, nil
      @ranks = {}

      teams.each.with_index do |(team, score), idx|
        if score != last
          last = score
          rank = idx + 1
        end

        @ranks[team] = { score: score, rank: rank }
      end

      @ranks
    end

    def scores
      scores = Hash.new { |h,k| h[k] = 0 }

      @scores ||= \
        @games.each_with_object(scores) do |game, ranks|
          team1, team2 = game.keys

          if game[team1] > game[team2] # win
            ranks[team1] += 3
            ranks[team2] += 0
          elsif game[team1] < game[team2] # loss
            ranks[team1] += 0
            ranks[team2] += 3
          else # tie
            ranks[team1] += 1
            ranks[team2] += 1
          end
        end
    end

  end


  class Printer

    def initialize(stream)
      @stream = stream
    end

    def print(ranks)
      ranks.each do |team, results|
        @stream.puts \
          "#{results[:rank]}. #{team}, #{results[:score]} pt#{?s if results[:score] != 1}"
      end
    end

  end

end
