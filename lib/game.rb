require 'game_choices'

class Game

	attr_reader :game_winner, :game_choices

	def initialize(game_choices=GameChoices.new(true,true))
		@points = []
		@game_winner = nil
		@game_choices = game_choices  #for doubles
	end

	def addpoint(point)
		@points << point
	end

	def deletepoint(player)
		indexes = @points.each_index.select { |i| @points[i].winner == player }
		if indexes.last	
			@points.delete_at(indexes.last)
		end
	end

	def player_points(player)
		@points.count { |point| point.winner == player }
	end

	def opponent_points(player)
		@points.count { |point| point.winner != player }
	end

	def total_points
		@points.length
	end

	def record_if_won_game(player)
		if (player_points(player) == 11 && opponent_points(player) <= 9) || (opponent_points(player) > 10 && two_ahead?(player))
			@game_winner = player
		end
	end

	def two_ahead?(player)
		player_points(player) == opponent_points(player) + 2
	end


	
end