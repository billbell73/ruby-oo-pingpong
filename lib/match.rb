# require_relative 'game'

class Match

	attr_accessor :games

	def initialize(player1, player2, best_of=1)
		@player1 = player1
		@player2 = player2
		@best_of = best_of
		@games = []
	end 

	def new_game
		@games << Game.new(@player1, @player2)
	end

	def increment_score(player)

		new_point = Point.new(player, server, player1_end)

	end

	def server
		game_odd == 1? odd_game_server : even_game_server
	end

	def odd_game_server
		points_serve_calc == 0? @player1 : @player2
	end

	def even_game_server
		points_serve_calc == 0? @player2 : @player1
	end

	def points_serve_calc
		(@games.last.total_points/2) % 2
	end 

	def game_odd
		@games.length % 2
	end





end