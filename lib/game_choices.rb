class GameChoices

	attr_reader :initial_server_first_partner

	def initialize(is_fp, ir_fp, p1_s=true )
		@initial_server_first_partner = is_fp  
		@initial_receiver_first_partner = ir_fp
		@p1_started_game_serving = p1_s
	end

	def server_is_first_partner?(points_played, p1_serving)
		if(@p1_started_game_serving == p1_serving)
			initial_serving_pair_first_partner_involved?(points_played)
		else 
			initial_receiving_pair_first_partner_involved?(points_played)
		end
	end

	def receiver_is_first_partner?(points_played, p1_serving)
		if(@p1_started_game_serving == p1_serving)
			initial_receiving_pair_first_partner_involved?(points_played)
		else 
			initial_serving_pair_first_partner_involved?(points_played)
		end
	end

	def initial_receiving_pair_first_partner_involved?(points_played)
		partner_toggle(points_played, 0) == 0 ? 
			@initial_receiver_first_partner : !@initial_receiver_first_partner
	end

	def initial_serving_pair_first_partner_involved?(points_played)
		partner_toggle(points_played, 2) == 0 ? 
			@initial_server_first_partner : !@initial_server_first_partner
	end

	private

	# def partner_toggle_first_receivers(points_played)
	# 	if points_played < 20
	# 		(points_played/4) % 2
	# 	else
	# 		(points_played/2) % 2
	# 	end 
	# end

	def partner_toggle(points_played, offset)
		toggle_number = points_played + offset
		if points_played < 22
			(toggle_number/4) % 2
		else
			(toggle_number/2) % 2
		end 
	end

end
