class MatchChoices

	def initialize(no_of_games, p1_starts_left, p1_first_server)
		@best_of = no_of_games
		@p1_starts_left = p1_starts_left
		@p1_first_server = p1_first_server
		@last_game = LastGame.new(p1_starts_left, p1_first_server)
		@odd_game = OddGame.new(p1_starts_left, p1_first_server)
		@even_game = EvenGame.new(p1_starts_left, p1_first_server)
	end

	def games_target
		(@best_of / 2) + 1
	end

	def p1_on_left?(nth_game, max_points)
		game_type(nth_game).p1_on_left?(max_points)
	end

	def game_type(nth_game)
		if nth_game == @best_of
			@last_game
		elsif nth_game % 2 == 1
			@odd_game
		else
			@even_game
		end
	end
	
	def p1_serving?(nth_game, points_played)
		game_type(nth_game).p1_serving?(points_played)
	end

end