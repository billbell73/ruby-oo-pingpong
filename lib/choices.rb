class Choices

	attr_reader :start_server

	def initialize(no_of_games, boolean, player)
		@best_of = no_of_games
		@player1_starts_left = boolean
		@start_server = player
	end

	def games_target
		(@best_of / 2) + 1
	end

	def player1_on_left?(nth_game)
		if @player1_starts_left
			game_odd?(nth_game)
		else
			!game_odd?(nth_game)
		end
	end

	def game_odd?(nth_game)
		nth_game % 2 == 1? true : false
	end

end