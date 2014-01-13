require_relative 'game'

class Match

	attr_reader :games

	def initialize(player1, player2, best_of=1)
		@player1 = player1
		@player2 = player2
		@best_of = best_of
		@games = []
	end 

	def new_game(parity=:odd)
		@games << Game.new(@player1, @player2, parity)
	end




end