class Point

	attr_reader :winner, :server, :player1_on_left

	def initialize(winner, server, player1_on_left)
		@winner = winner
		@server = server
		
		# this is at point level because..
		@player1_on_left = player1_on_left
	end

end