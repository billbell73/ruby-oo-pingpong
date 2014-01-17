require 'choices'

describe Choices do 

	let(:player1) {double :player}
	let(:choices1) { Choices.new(3, true, player1) }
	let(:choices2) { Choices.new(5, false, player1) }

	it 'says who started serving in first game' do
		expect(choices1.start_server).to equal player1
	end

	it 'can tell winning 2 games wins default match' do
		expect(choices1.games_target).to equal 2
	end

	it 'can tell winning 3 games wins best-of-five match' do
		expect(choices2.games_target).to equal 3
	end

	it 'says player1 on left for 1st game' do
		expect(choices1.player1_on_left?(1)).to equal true
	end

	it 'says player1 on right for 2nd game' do
		expect(choices1.player1_on_left?(2)).to equal false
	end

	it 'can tell player side in normal game of 5 game match' do
		expect(choices2.player1_on_left?(4)).to equal true
	end
	
end