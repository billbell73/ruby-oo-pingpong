class Choices

	def initialize(no_of_games, player1_starts_left, player1_first_server)
		@best_of = no_of_games
		@player1_starts_left = player1_starts_left
		@player1_first_server = player1_first_server
		@last_game = LastGame.new(player1_starts_left, player1_first_server)
		@odd_game = OddGame.new(player1_starts_left, player1_first_server)
		@even_game = EvenGame.new(player1_starts_left, player1_first_server)
	end

	def games_target
		(@best_of / 2) + 1
	end

	def player1_on_left?(nth_game)
		game_type(nth_game).player1_on_left?
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
	
	def player1_serving?(nth_game, points_played)
		game_type(nth_game).player1_serving?(points_played)
	end


end