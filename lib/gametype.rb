class GameType
	def initialize(player1_starts_left, player1_first_server)
		@player1_starts_left = player1_starts_left
		@player1_first_server = player1_first_server
		@five_reached_in_last_possible_game = false
	end

	def serve_toggle(points_played)
		if points_played < 20
			(points_played/2) % 2
		else
			points_played % 2
		end 
	end

end

class OddGame < GameType
	def player1_on_left?(max_points)
		@player1_starts_left
	end

	def player1_serving?(points_played)
		serve_toggle(points_played) == 0? @player1_first_server : !@player1_first_server
	end
end


class EvenGame < GameType
	def player1_on_left?(max_points)
		!@player1_starts_left
	end

	def player1_serving?(points_played)
		serve_toggle(points_played) == 0? !@player1_first_server : @player1_first_server
	end
end

class LastGame < OddGame
	def player1_on_left?(max_points)
		max_points < 5 ? @player1_starts_left : !@player1_starts_left
	end

end

