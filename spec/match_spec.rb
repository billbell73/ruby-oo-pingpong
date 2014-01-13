require 'match'

describe Match do

	let(:player1) {double :player}
	let(:player2) {double :player}

	let(:match) { Match.new player1, player2 }
	let(:match5) { Match.new player1, player2, 5}

	let(:point) {double :point}

	let(:game0) { double :game, total_points: 0}
	let(:game1) { double :game, total_points: 2}
	let(:game2) { double :game, total_points: 7}

	


	it 'can start a game' do 
		match.new_game
		expect(match.games.length).to equal 1
	end

	it 'can ascertain when game odd or even' do
		match.new_game
		expect(match.game_odd?).to equal true
	end

	it 'says player1 serving after 0 points' do
		match.games = [game0]
		expect(match.server).to equal player1
	end

	it 'says player2 serving after 2 points' do
		match.games = [game1]
		expect(match.server).to equal player2
	end

	it 'says player2 serving after 7 points' do
		match.games = [game2]
		expect(match.server).to equal player2
	end

	it 'says player1 on left for 1st game' do
		match.games = [game1]
		expect(match.player1_end).to equal :left
	end

	it 'says player1 on right for 2nd game' do
		match.games = [game0, game1]
		expect(match.player1_end).to equal :right
	end

	it 'can increment score from 0-0' do
		match.new_game
		match.increment_score(player2)
		expect(match.games.last.points(player2)).to equal 1
	end

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

	it 'can increment score from 4-7' do
		set_score(4, 7)
		match.increment_score(player2)
		expect(match.games.last.points(player1)).to equal 4
		expect(match.games.last.points(player2)).to equal 8
	end

	it 'can decrement player1\'s score from 4-7' do
		set_score(4, 7)
		match.decrement_score(player1)
		expect(match.games.last.points(player1)).to equal 3
		expect(match.games.last.points(player2)).to equal 7
	end

	it 'can increment from 10-7 so player1 wins game and new game starts' do
		set_score(10, 7)
		match.increment_score(player1)
		expect(match.games.length).to equal 2
		expect(match.games.last.points(player1)).to equal 0
	end

	it 'can increment from 7-11, 0-10 so player2 wins match' do
		set_score(7, 11, 6, 10)
		match.increment_score(player2)
		expect(match.games.length).to equal 2
		expect(match.games.last.points(player2)).to equal 11
	end

	it 'can tell winning 2 games wins default match' do
		expect(match.games_target).to equal 2
	end

	it 'can tell winning 3 games wins best-of-five match' do
		expect(match5.games_target).to equal 3
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

	it 'can tell if match winner in best-of-five match' do
		set_score(7, 11, 7, 11, match5)
		increment(11, match5, player1)
		increment(11, match5, player1)
		increment(10, match5, player2)
		expect(match5.match_winner).to be_nil
		match5.increment_score(player2)
		expect(match5.match_winner).to equal player2
	end
















	xit 'can decrement player1\'s score from 0-0 in second game' do

	end


	
end