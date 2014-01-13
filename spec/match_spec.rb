require 'match'

describe Match do

let(:player1) {double :player}
let(:player2) {double :player}

let(:match) { Match.new player1, player2 }

it 'can start a game' do 
	match.new_game
	expect(match.games.length).to equal 1
end

xit 'can ' do
end
	
end