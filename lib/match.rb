# require_relative 'game'

class Match

	attr_accessor :games

	def initialize(player1, player2, best_of=1)
		@player1 = player1
		@player2 = player2
		@best_of = best_of
		@games = []
	end 

	def new_game(parity=:odd)
		@games << Game.new(@player1, @player2, parity)
	end

	def increment_score(player)

		new_point = Point.new(player, server, player1_end)

	end

	def server
		if game_odd
			odd_game_server
		end

	end

	def odd_game_server
		if points_serve_calc == 0
			@player1
		else
			@player2
		end

	end

	def points_serve_calc
		(@games.last.total_points/2) % 2
	end 

	def game_odd
		@games.length % 2
	end





end