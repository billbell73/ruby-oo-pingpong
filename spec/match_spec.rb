require 'match'

describe Match do

let(:player1) {double :player}
let(:player2) {double :player}

let(:match) { Match.new player1, player2 }

let(:game1) { double :game, total_points: 5}
let(:game2) { double :game, total_points: 7}

it 'can start a game' do 
	match.new_game
	expect(match.games.length).to equal 1
end

it 'can ascertain when game odd or even' do
	match.new_game
	expect(match.game_odd).to equal 1
end

it 'says player1 serving after 5 points' do
	match.games = [game1]
	expect(match.server).to equal player1
end

it 'says player2 serving after 7 points' do
	match.games = [game2]
	expect(match.server).to equal player2
end

xit 'can increment score' do
	match.increment_score(player2)
	expect(match.games.last.player_points(player2)).to equal 1
end
	
end