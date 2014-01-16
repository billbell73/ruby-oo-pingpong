class Choices

	attr_reader :best_of, :start_player1_side, :start_server

	def initialize(no_of_games, side, player)
		@best_of = no_of_games
		@start_player1_side = side
		@start_server = player
	end

end