class Game

	attr_reader :game_winner, :first_partner_first_server

	def initialize(fp_fs=true, fp_fr=true)
		@points = []
		@game_winner = nil

		#for doubles
		@first_partner_first_server = fp_fs  
		@first_partner_first_receiver = fp_fr
	end

	def addpoint(point)
		@points << point
	end

	def deletepoint(player)
		indexes = @points.each_index.select { |i| @points[i].winner == player }
		if indexes.last	
			@points.delete_at(indexes.last)
		end
	end

	def player_points(player)
		@points.count { |point| point.winner == player }
	end

	def opponent_points(player)
		@points.count { |point| point.winner != player }
	end

	def total_points
		@points.length
	end

	def record_if_won_game(player)
		if (player_points(player) == 11 && opponent_points(player) <= 9) || (opponent_points(player) > 10 && two_ahead?(player))
			@game_winner = player
		end
	end

	def two_ahead?(player)
		player_points(player) == opponent_points(player) + 2
	end


	def first_partner_serving?
		partner_toggle == 0 ? @first_partner_first_server : !@first_partner_first_server
	end

	def first_partner_receiving?
		partner_toggle == 0 ? @first_partner_first_receiver : !@first_partner_first_receiver
	end

	def partner_toggle
		(total_points/4) % 2
	end

end