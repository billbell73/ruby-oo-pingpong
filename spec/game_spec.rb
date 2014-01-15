require 'game'

describe Game do 

	let(:player1) {double :player}
	let(:player2) {double :player}

	let(:game) { Game.new player1, player2 }
	let(:point1) { double :point, winner: player1}
	let(:point2) { double :point, winner: player2}


	def set_score player1_points, player2_points
		player1_points.times{game.addpoint(point1)}
		player2_points.times{game.addpoint(point2)}
	end

	it 'no points for players at start' do
		expect(game.points(player2)).to equal 0
	end

	it 'can add point to a player\'s in-game score' do
		game.addpoint(point1)
		expect(game.points(player1)).to equal 1
	end

	it 'can delete point from player\'s in-game score' do
		game.addpoint(point1)
		game.deletepoint(player1)
		expect(game.points(player1)).to equal 0
	end

	it 'no winner if neither player has reached 11' do
		set_score 10, 10
		expect(game.ascertain_winner(player1, player2)).to be_nil
	end

	it 'player 1 wins if reaches 11 and player 2 has none' do
		set_score 11, 0
		expect(game.ascertain_winner(player1, player2)).to equal player1
	end

	it 'player 2 wins if reaches 11 and player 1 has none' do
		set_score 0, 11
		expect(game.ascertain_winner(player1, player2)).to equal player2
	end

	it 'can easily access points of opponent' do
		set_score 0, 7
		expect(game.opponent_points(player1)).to equal 7
	end

	it 'player 1 doesn\'t win if gets 11, but player 2 has 10' do
	 	set_score 11, 10
	 	expect(game.ascertain_winner(player1, player2)).to be_nil
	end

	it 'if player 2 has more than 11, player 1 wins on 13' do
		set_score 13, 11
		expect(game.ascertain_winner(player1, player2)).to equal player1
	end

	it 'if player 2 has 14 and player 1 has 13, no winner' do
		set_score 13, 14
		expect(game.ascertain_winner(player1, player2)).to be_nil
	end

	it 'knows the total points played' do
		set_score 13, 14
		expect(game.total_points).to equal 27
	end


end