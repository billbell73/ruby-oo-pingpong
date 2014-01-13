# require_relative 'point'

class Game

	def initialize(player1, player2)
		@player_points = [[],[]]
		@player1 = player1
		@player2 = player2
		@player_index = { @player1 => 0, @player2 => 1 }
		@winner = nil
	end

	def addpoint(point)
		index = @player_index[point.winner]
		@player_points[index] << point
	end

	def deletepoint(point)
		index = @player_index[point.winner]
		@player_points[index].pop
	end

	def points(player)
		index = @player_index[player]
		@player_points[index].length
	end

	def opponent_points(player)
		index = @player_index[player]
		@player_points[index-1].length
	end

	def total_points
		@player_points[0].length + @player_points[1].length
	end

	def winner
		check_winner(@player1)
		check_winner(@player2)
		@winner
	end

	def check_winner(player)
		if points(player) == 11 && opponent_points(player) <= 9
			@winner = player
		elsif opponent_points(player) > 10 && two_ahead?(player)
			@winner = player
		end
	end

	def two_ahead?(player)
		points(player) == opponent_points(player) + 2
	end

end