require 'game'

describe Game do 

	let(:player1) {double :player}
	let(:player2) {double :player}

	let(:game) { Game.new }
	let(:point1) { double :point, winner: player1}
	let(:point2) { double :point, winner: player2}


	def set_score player1_points, player2_points
		player1_points.times{game.addpoint(point1)}
		player2_points.times{game.addpoint(point2)}
	end

	it 'no points for players at start' do
		expect(game.player_points(player2)).to equal 0
	end

	it 'can add point to a player\'s in-game score' do
		game.addpoint(point1)
		expect(game.player_points(player1)).to equal 1
	end

	it 'can delete point from player\'s in-game score' do
		game.addpoint(point1)
		game.deletepoint(player1)
		expect(game.player_points(player1)).to equal 0
	end

	it 'attempting to delete point from player with no score leaves player on 0' do
		set_score(4, 0)
		game.deletepoint(player2)
		expect(game.player_points(player2)).to equal 0
	end

	it 'no winner if neither player has reached 11' do
		set_score 10, 10
		expect(game.record_if_won_game(player2)).to be_nil
	end

	it 'player 1 wins if reaches 11 and player 2 has none' do
		set_score 11, 0
		expect(game.record_if_won_game(player1)).to equal player1
	end

	it 'player 2 wins if reaches 11 and player 1 has none' do
		set_score 0, 11
		expect(game.record_if_won_game(player2)).to equal player2
	end

	it 'can easily access points of opponent' do
		set_score 0, 7
		expect(game.opponent_points(player1)).to equal 7
	end

	it 'player 1 doesn\'t win if gets 11, but player 2 has 10' do
	 	set_score 11, 10
	 	expect(game.record_if_won_game(player1)).to be_nil
	end

	it 'if player 2 has more than 11, player 1 wins on 13' do
		set_score 13, 11
		expect(game.record_if_won_game(player1)).to equal player1
	end

	it 'if player 2 has 14 and player 1 has 13, no winner' do
		set_score 13, 14
		expect(game.record_if_won_game(player1)).to be_nil
	end

	it 'knows the total points played' do
		set_score 13, 14
		expect(game.total_points).to equal 27
	end

	context 'Doubles' do

		let(:gamedub) { gamedub = Game.new(true, true) }

		it 'knows which partner of first pair to serve is first server' do
			expect(gamedub.first_partner_first_server).to equal true
		end

		it 'knows which partner serving for second point' do
			gamedub.stub(:total_points).and_return(1)
			expect(gamedub.first_partner_serving?).to equal true
		end

		it 'knows which partner serving for sixth point' do
			gamedub.stub(:total_points).and_return(5)
			expect(gamedub.first_partner_serving?).to equal false
		end

		it 'knows which partner receiving for second point' do
			gamedub.stub(:total_points).and_return(1)
			expect(gamedub.first_partner_receiving?).to equal true
		end




	end


end