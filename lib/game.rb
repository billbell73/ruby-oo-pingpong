class Game

	attr_reader :winner

	def initialize
		@points = []
		@winner = nil
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
			@winner = player
		end
	end

	def two_ahead?(player)
		player_points(player) == opponent_points(player) + 2
	end

end