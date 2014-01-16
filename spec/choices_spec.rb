require 'choices'

describe Choices do 

	let(:player1) {double :player}
	let(:choices1) { Choices.new(3, :left, player1) }

	it 'says best of how many games' do
		expect(choices1.best_of).to equal 3
	end

	it 'says on which side player1 started' do
		expect(choices1.start_player1_side).to equal :left
	end

	it 'says who started serving in first game' do
		expect(choices1.start_server).to equal player1
	end
	
end