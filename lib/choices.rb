class Choices

	def initialize(no_of_games, player1_starts_left, player1_first_server)
		@best_of = no_of_games
		@player1_starts_left = player1_starts_left
		@player1_first_server = player1_first_server
	end

	def games_target
		(@best_of / 2) + 1
	end

	def player1_on_left?(nth_game)
		if game_type(nth_game) == :last
			@player1_starts_left
		elsif game_type(nth_game) == :odd
			@player1_starts_left
		else
			!@player1_starts_left
		end
	end

	def game_type(nth_game)
		if nth_game == @best_of
			:last
		elsif nth_game % 2 == 1
			:odd
		else
			:even
		end
	end
	
	def player1_serving?(nth_game, points_played)
		game_odd?(nth_game) == true ? odd_game_server(points_played) : even_game_server(points_played)
	end

	def game_odd?(nth_game)
		nth_game % 2 == 1? true : false
	end

	def odd_game_server(points_played)
		serve_toggle(points_played) == 0? @player1_first_server : !@player1_first_server
	end

	def even_game_server(points_played)
		serve_toggle(points_played) == 0? !@player1_first_server : @player1_first_server
	end

	def serve_toggle(points_played)
		(points_played/2) % 2
	end 

end