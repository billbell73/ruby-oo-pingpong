class GameType
	def initialize(player1_starts_left, player1_first_server)
		@player1_starts_left = player1_starts_left
		@player1_first_server = player1_first_server
	end

	def serve_toggle(points_played)
		(points_played/2) % 2
	end 
end

class OddGame < GameType
	def player1_on_left?
		@player1_starts_left
	end

	def player1_serving?(points_played)
		serve_toggle(points_played) == 0? @player1_first_server : !@player1_first_server
	end
end


class EvenGame < GameType
	def player1_on_left?
		!@player1_starts_left
	end

	def player1_serving?(points_played)
		serve_toggle(points_played) == 0? !@player1_first_server : @player1_first_server
	end
end

class LastGame < OddGame
	def player1_on_left?(nth_point)
		last_game_end(nth_point)
	end
end

