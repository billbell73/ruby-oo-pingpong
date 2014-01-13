require 'match'

describe Match do

	let(:player1) {double :player}
	let(:player2) {double :player}

	let(:match) { Match.new player1, player2 }

	let(:point) {double :point}

	let(:game0) { double :game, total_points: 0}
	let(:game1) { double :game, total_points: 2}
	let(:game2) { double :game, total_points: 7, player_points: [[4],[3]] }


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

	it 'can increment score from 4-3' do
		match.games = [game2]
		match.increment_score(player2)
		expect(match.games.last.points(player2)).to equal 4
	end


	
end