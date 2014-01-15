class Game

	def initialize
		@player_points = []
		@winner = nil
	end

	def addpoint(point)
		@player_points << point
	end

	def deletepoint(player)
		indexes = @player_points.each_index.select { |i| @player_points[i].winner == player }
		@player_points.delete_at(indexes.last)
	end

	def points(player)
		@player_points.count { |point| point.winner == player }
	end

	def opponent_points(player)
		@player_points.count { |point| point.winner != player }
	end

	def total_points
		@player_points.length
	end

	def ascertain_winner(player1, player2)
		record_if_won(player1)
		record_if_won(player2)
		@winner
	end

	def record_if_won(player)
		if (points(player) == 11 && opponent_points(player) <= 9) || (opponent_points(player) > 10 && two_ahead?(player))
			@winner = player
		end
	end

	def two_ahead?(player)
		points(player) == opponent_points(player) + 2
	end

end