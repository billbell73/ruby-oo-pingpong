require 'game_choices'

describe 'GameChoices' do

		let(:game_choices1) { GameChoices.new(true,true) }
		let(:game_choices2) { GameChoices.new(true,false)}
		let(:game_choices3) { GameChoices.new(false,false)}

		it 'knows which partner of inital pair to serve is initial server' do
			expect(game_choices1.initial_server_first_partner).to equal true
		end

		it 'knows which of initial receiver pair is involved in first shot of a point' do
			expect(game_choices1.initial_receiving_pair_first_partner_involved?(5)).to equal false
		end

		it 'knows which of initial serving pair is involved in first shot of point 1' do
			expect(game_choices1.initial_serving_pair_first_partner_involved?(0)).to equal true
		end

		it 'knows which of initial server pair is involved in first shot of point 6' do
			expect(game_choices1.initial_serving_pair_first_partner_involved?(5)).to equal false
		end

		it 'knows which partner of pair is serving for 3rd point' do
			expect(game_choices1.server_is_first_partner?(2, false)).to equal true
		end

		it 'knows which partner of pair is serving for 5th point' do
			expect(game_choices1.server_is_first_partner?(4, true)).to equal false
		end

		it 'knows which partner of pair is receiving for 3rd point' do
			expect(game_choices2.receiver_is_first_partner?(2, false)).to equal false
		end

		it 'knows which partner of pair is receiving for 5th point' do
			expect(game_choices2.receiver_is_first_partner?(4, true)).to equal true
		end

end