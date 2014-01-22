class GameChoices

	attr_reader :first_partner_first_server

	def initialize(fp_fs, fp_fr)
		@first_partner_first_server = fp_fs  
		@first_partner_first_receiver = fp_fr
	end


	def first_partner_serving?(points_played, p1_serving)
		if first_server_partner_number_equals_receiver? || p1_serving
			first_partner_of_first_pair_serving?(points_played)
		else
			!first_partner_of_first_pair_serving?(points_played)
		end
	end

	def first_partner_of_first_pair_serving?(points_played)
		partner_toggle(points_played) == 0 ? @first_partner_first_server : !@first_partner_first_server
	end

	def first_partner_receiving?(points_played)
		partner_toggle(points_played) == 0 ? @first_partner_first_receiver : !@first_partner_first_receiver
	end

	private

	def partner_toggle(points_played)
		if points_played < 20
			(points_played/4) % 2
		else
			(points_played/2) % 2
		end 
	end

	def first_server_partner_number_equals_receiver?
		@first_partner_first_server == @first_partner_first_receiver
	end

end
