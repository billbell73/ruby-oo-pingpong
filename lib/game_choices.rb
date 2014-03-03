class GameChoices

	attr_reader :first_partner_first_server

	def initialize(fp_fs, fp_fr, p1_s=true )
		@first_partner_first_server = fp_fs  
		@first_partner_first_receiver = fp_fr
		@p1_started_game_serving = p1_s
	end

	def server_is_index0?(points_played, p1_serving)
		if(@p1_started_game_serving == p1_serving)
			first_serving_pair_first_partner_involved?(points_played)
		else 
			first_receiving_pair_first_partner_involved?(points_played)
		end
	end

	def receiver_is_index0?(points_played, p1_serving)
		if(@p1_started_game_serving == p1_serving)
			first_receiving_pair_first_partner_involved?(points_played)
		else 
			first_serving_pair_first_partner_involved?(points_played)
		end
	end

	def first_receiving_pair_first_partner_involved?(points_played)
		partner_toggle(points_played, 0) == 0 ? @first_partner_first_receiver : !@first_partner_first_receiver
	end

	def first_serving_pair_first_partner_involved?(points_played)
		partner_toggle(points_played, 2) == 0 ? @first_partner_first_server : !@first_partner_first_server
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
