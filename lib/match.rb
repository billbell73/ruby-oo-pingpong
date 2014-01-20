require_relative 'game'
require_relative 'point'

class Match

	attr_accessor :games
	attr_reader :match_winner

	def initialize(choices, participant1, participant2, participant3=nil, participant4=nil)
		if participant4
			@p1 = [participant1, participant2]
			@p2 = [participant3, participant4]
			@doubles_match = true
		else
			@p1 = participant1
			@p2 = participant2
			@doubles_match = false
		end
		@choices = choices
		@games = []
		@match_winner = nil
	end 

	def doubles_match?
		@doubles_match
	end

	def new_game
		@games << Game.new
	end

	def current_game
		@games.last
	end

	def increment_score(point_winner)
		new_point = Point.new(point_winner, server, p1_on_left?)
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

	def p1_on_left?
		@choices.p1_on_left?(@games.length, max_points_in_current_game)
	end

	def p1_serving?
		@choices.p1_serving?(@games.length, current_game.total_points)
	end

	def server
		p1_serving? ? @p1 : @p2
	end

	def game_score(game_no, player)
		@games[game_no - 1].player_points(player)
	end

	def max_points_in_current_game
		[current_game.player_points(@p1), current_game.player_points(@p2)].max
	end


end