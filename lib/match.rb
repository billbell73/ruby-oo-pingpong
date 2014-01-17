require_relative 'game'
require_relative 'point'

class Match

	attr_accessor :games
	attr_reader :match_winner

	def initialize(player1, player2, choices)
		@player1 = player1
		@player2 = player2
		@choices = choices
		@games = []
		@match_winner = nil
	end 

	def new_game
		@games << Game.new
	end

	def current_game
		@games.last
	end

	def increment_score(point_winner)
		new_point = Point.new(point_winner, server, player1_on_left?)
		current_game.addpoint(new_point)
		if current_game.record_if_won_game(point_winner)
			finish_game
		end
	end

	def games_won(player)
		@games.count { |game| game.winner == player }
	end

	def finish_game
		if games_won(@player1) == @choices.games_target
			@match_winner = @player1
		elsif games_won(@player2) == @choices.games_target
			@match_winner = @player2
		else
			new_game
		end
	end

	def decrement_score(winner)
		current_game.deletepoint(winner)
	end

	def player1_on_left?
		@choices.player1_on_left?(@games.length)
	end

	def player1_serving?
		@choices.player1_serving?(@games.length, current_game.total_points)
	end

	def server
		player1_serving? == true ? @player1 : @player2
	end

	def game_score(game_no, player)
		@games[game_no - 1].player_points(player)
	end


end