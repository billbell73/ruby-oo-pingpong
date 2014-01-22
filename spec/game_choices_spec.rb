require 'game_choices'

describe 'GameChoices' do

		let(:game_choices1) { GameChoices.new(true,true) }
		let(:game_choices2) { GameChoices.new(true,false)}
		let(:game_choices3) { GameChoices.new(false,false)}

		it 'knows which partner of first pair to serve is first server' do
			expect(game_choices1.first_partner_first_server).to equal true
		end

		it 'knows which partner serving for second point' do
			expect(game_choices1.first_partner_serving?(1, true)).to equal true
		end

		it 'knows which partner receiving for second point' do
			expect(game_choices1.first_partner_receiving?(1)).to equal true
		end

		it 'knows which partner is serving for 3rd point when 1st receiver is 1st partner' do
			expect(game_choices1.first_partner_serving?(2, false)).to equal true
		end

		it 'knows server for 3rd point when 1st receiver is 2nd partner' do
			expect(game_choices2.first_partner_serving?(2, false)).to equal false
		end

		it 'knows server for 5th point when 1st receiver is 2nd partner' do
			expect(game_choices3.first_partner_serving?(4, true)).to equal true
		end

		it 'knows servers for points after 10-all' do
			expect(game_choices3.first_partner_serving?(22, true)).to equal true
		end





	end