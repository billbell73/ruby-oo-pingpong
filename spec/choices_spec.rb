require 'choices'
require 'gametype'

describe Choices do 

	let(:choices1) { Choices.new(3, true, true) }
	let(:choices2) { Choices.new(5, false, false) }


	it 'can tell winning 2 games wins default match' do
		expect(choices1.games_target).to equal 2
	end

	it 'can tell winning 3 games wins best-of-five match' do
		expect(choices2.games_target).to equal 3
	end

	it 'says player1 on left for 1st game' do
		expect(choices1.p1_on_left?(1, 4)).to equal true
	end

	it 'says player1 on right for 2nd game' do
		expect(choices1.p1_on_left?(2, 10)).to equal false
	end

	it 'can tell player side in normal game of 5 game match' do
		expect(choices2.p1_on_left?(4, 2)).to equal true
	end

	it 'can tell player side in last possible game of match' do
		expect(choices2.p1_on_left?(5, 3)).to equal false
		expect(choices2.p1_on_left?(5, 10)).to equal true
	end

	# it 'can tell game type \'even\'' do
	# 	expect(choices1.game_type(2)).to equal :even
	# end

	# it 'can tell game type \'last\'' do
	# 	expect(choices1.game_type(3)).to equal :last
	# end

	


	it 'says player1 serving after 0 points if starts serving' do
		expect(choices1.p1_serving?(1,0)).to equal true
	end

	it 'says player2 serving after 2 points if player1 starts' do
		expect(choices1.p1_serving?(1,2)).to equal false
	end

	it 'says player1 serving after 6 points if player2 started' do
		expect(choices2.p1_serving?(1,6)).to equal true
	end

	it 'says player2 serving after 0 points of 2nd game if player1 starts serving' do
		expect(choices1.p1_serving?(2,0)).to equal false
	end

	it 'says player 1 serving after 4 points of 4th game if player 2 started' do
		expect(choices2.p1_serving?(4,4)).to equal true
	end

	

	
end