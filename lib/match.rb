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
			finish_game(point_winner)
		end
	end

	def games_won(player)
		@games.count { |game| game.winner == player }
	end

	def finish_game(point_winner)
		if games_won(point_winner) == @choices.games_target
			@match_winner = point_winner
		else
			new_game
		end
	end

	def decrement_score(winner)
		if current_game.total_points != 0
			current_game.deletepoint(winner)
		else
			@games.pop
		end
	end

	def player1_on_left?
		@choices.player1_on_left?(@games.length, max_points_in_current_game)
	end

	def player1_serving?
		@choices.player1_serving?(@games.length, current_game.total_points)
	end

	def server
		player1_serving? ? @player1 : @player2
	end

	def game_score(game_no, player)
		@games[game_no - 1].player_points(player)
	end

	def max_points_in_current_game
		[current_game.player_points(@player1), current_game.player_points(@player2)].max
	end


end