require 'choices'

describe Choices do 

	let(:player1) {double :player}
	let(:choices1) { Choices.new(3, :left, player1) }
	let(:choices2) { Choices.new(5, :left, player1) }

	it 'says best of how many games' do
		expect(choices1.best_of).to equal 3
	end

	it 'says on which side player1 started' do
		expect(choices1.start_player1_side).to equal :left
	end

	it 'says who started serving in first game' do
		expect(choices1.start_server).to equal player1
	end

	it 'can tell winning 2 games wins default match' do
		expect(choices1.games_target).to equal 2
	end

	it 'can tell winning 3 games wins best-of-five match' do
		expect(choices2.games_target).to equal 3
	end
	
end