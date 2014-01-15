require_relative 'game'
require_relative 'point'

class Match

	attr_accessor :games
	attr_reader :match_winner

	def initialize(player1, player2, best_of=3)
		@player1 = player1
		@player2 = player2
		@best_of = best_of
		@games = []
		@match_winner = nil
	end 

	def new_game
		@games << Game.new(@player1, @player2)
	end

	def increment_score(winner)
		new_point = Point.new(winner, server, player1_end)
		@games.last.addpoint(new_point)
		if @games.last.winner
			finish_game
		end
	end

	def games_target
		(@best_of / 2) + 1
	end

	def games_won(player)
		@games.count { |game| game.winner == player }
	end

	def finish_game
		if games_won(@player1) == games_target
			@match_winner = @player1
		elsif games_won(@player2) == games_target
			@match_winner = @player2
		else
			new_game
		end
	end

	def decrement_score(winner)
		@games.last.deletepoint(winner)
	end

	def server
		game_odd? == true ? odd_game_server : even_game_server
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

	def game_odd?
		@games.length % 2 == 1? true : false
	end

	def player1_end
		game_odd? == true ? :left : :right
	end





end