require 'match'
require 'choices'

describe Match do

	let(:player1) {double :player}
	let(:player2) {double :player}

	let(:choices1) { double :choices, games_target: 2, player1_serving?: true, player1_on_left?: true }
	let(:choices2) { double :choices, games_target: 3 }

	let(:choices3) { Choices.new(3, true, true)}

	let(:match) { Match.new player1, player2, choices1 }
	let(:match5) { Match.new player1, player2, choices2 }

	let(:point) {double :point}

	let(:game0) { double :game, total_points: 0}
	let(:game1) { double :game, total_points: 2}
	let(:game2) { double :game, total_points: 7}

	def set_score(p1_game1, p2_game1, p1_game2=0, p2_game2=0, match=match)
		match.new_game
		increment(p1_game1, match, player1)
		increment(p2_game1, match, player2)
		increment(p1_game2, match, player1)
		increment(p2_game2, match, player2)
	end

	def increment(number, match, player)
		number.times{ match.increment_score(player) }
	end

	it 'can start a game' do 
		match.new_game
		expect(match.games.length).to equal 1
	end

	it 'knows last point and next point server' do
		set_score(1, 0)
		expect(choices1).to receive(:player1_serving?).with(1,1)
		match.server
		match.increment_score(player2)
		expect(choices1).to receive(:player1_serving?).with(1,2)
		match.server
	end

	xit 'can tell if player1 on left' do
		set_score(3, 11, 4, 2)
		expect(choices1).to receive(:player1_on_left?).with(2)
		match.player1_on_left?
	end

	it 'can tell if player1 on left in first game' do
		set_score(3, 10)	
		expect(match.player1_on_left?).to equal true
	end

	it 'can tell if player1 on left in second game' do
		set_score(3, 11, 0, 2)	
		expect(choices1).to receive(:player1_on_left?).with(2)
		match.player1_on_left?
	end

	it 'can increment score from 0-0' do
		match.new_game
		match.increment_score(player2)
		expect(match.games.last.player_points(player2)).to equal 1
	end

	it 'can increment score from 4-7' do
		set_score(4, 7)
		match.increment_score(player2)
		expect(match.games.last.player_points(player1)).to equal 4
		expect(match.games.last.player_points(player2)).to equal 8
	end

	it 'can decrement player1\'s score from 4-7' do
		set_score(4, 7)
		match.decrement_score(player1)
		expect(match.games.last.player_points(player1)).to equal 3
		expect(match.games.last.player_points(player2)).to equal 7
	end

	it 'can increment from 10-7 so player1 wins game and new game starts' do
		set_score(10, 7)
		match.increment_score(player1)
		expect(match.games.length).to equal 2
		expect(match.games.last.player_points(player1)).to equal 0
	end

	it 'can increment from 7-11, 0-10 so player2 wins match' do
		set_score(7, 11, 6, 10)
		match.increment_score(player2)
		expect(match.games.length).to equal 2
		expect(match.games.last.player_points(player2)).to equal 11
	end

	it 'can tell how many games a player has won' do
		set_score(7, 11, 11, 6)
		expect(match.games_won(player2)).to equal 1
		expect(match.games_won(player1)).to equal 1
	end

	it 'can tell if match winner in default best-of-three match' do
		set_score(7, 11, 7, 10)
		match.increment_score(player2)
		expect(match.match_winner).to equal player2
	end

	it 'can tell when no player has won yet' do
		set_score(7, 11, 7, 9)
		match.increment_score(player2)
		expect(match.match_winner).to be_nil
	end

	xit 'can tell if match winner in best-of-five match' do
		set_score(7, 11, 7, 11, match5)
		increment(11, match5, player1)
		increment(11, match5, player1)
		increment(10, match5, player2)
		expect(match5.match_winner).to be_nil
		match5.increment_score(player2)
		expect(match5.match_winner).to equal player2
	end

	it 'can tell player1 game 1 score' do
		set_score(3, 11, 2, 4)
		expect(match.game_score(1, player1)).to equal 3
	end

	it 'can tell player2 game 2 score' do
		set_score(3, 11, 2, 4)
		expect(match.game_score(2, player2)).to equal 4
	end


	it 'can decrement player1\'s score from 0-0 in second game' do
		pending("implementing deletion across game boundaries") do
			set_score(3, 11, 0, 0)
			match.decrement_score(player2)
			expect(match.games_score(1, player2)).to equal 10
		end
	end




	
end