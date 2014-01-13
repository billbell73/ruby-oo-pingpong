require 'point'

describe Point do 

	let(:point) { Point.new(:player1, :player2, :left) }

	it 'has a winner' do
		 expect(point.winner).to equal :player1
	end

	it 'has a server' do
		expect(point.server).to equal :player2
	end

	it 'knows which end player 1 is' do
		expect(point.player1_end).to equal :left
	end


end