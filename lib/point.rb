class Point

	attr_reader :winner, :server, :player1_end

	def initialize(winner, server, player1_end)
		@winner = winner
		@server = server
		@player1_end = player1_end
	end

end