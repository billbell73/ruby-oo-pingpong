require 'game_choices'

describe 'GameChoices' do

		let(:game_choices1) { GameChoices.new(true,true) }
		let(:game_choices2) { GameChoices.new(true,false)}
		let(:game_choices3) { GameChoices.new(false,false)}

		it 'knows which partner of first pair to serve is first server' do
			expect(game_choices1.first_partner_first_server).to equal true
		end

		it 'knows which of first-receiver-pair involved in a point' do
			expect(game_choices1.first_receiving_pair_first_partner_involved?(5)).to equal false
		end

		it 'knows which of first-server-pair involved in point 1' do
			expect(game_choices1.first_serving_pair_first_partner_involved?(0)).to equal true
		end

		it 'knows which of first-server-pair involved in point 6' do
			expect(game_choices1.first_serving_pair_first_partner_involved?(5)).to equal false
		end

		it 'knows partner-index of server' do
			expect(game_choices1.server_is_index0?(2, false)).to equal true
		end

		it 'knows partner-index of server' do
			expect(game_choices1.server_is_index0?(4, true)).to equal false
		end

		it 'knows partner-index of receiver' do
			expect(game_choices2.receiver_is_index0?(2, false)).to equal false
		end

		it 'knows partner-index of receiver' do
			expect(game_choices2.receiver_is_index0?(4, true)).to equal true
		end

end