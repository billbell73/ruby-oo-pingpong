require 'match'

describe Match do

	let(:player1) {double :player}
	let(:player2) {double :player}
	let(:match_choices1) { double :match_choices, games_target: 2, 
																p1_serving?: true, p1_on_left?: true }
	
	let(:match) { Match.new match_choices1, player1, player2 }

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

	context 'Best of 3-game match' do

		it 'can start a game' do 
			match.new_game
			expect(match.games.length).to equal 1
		end

		it 'can find out last point and next point server' do
			set_score(1, 0)
			expect(match_choices1).to receive(:p1_serving?).with(1,1)
			match.server
			match.increment_score(player2)
			expect(match_choices1).to receive(:p1_serving?).with(1,2)
			match.server
		end

		it 'can find out if player1 on left' do
			set_score(3, 11, 0, 2)	
			expect(match_choices1).to receive(:p1_on_left?).with(2, 2)
			match.p1_on_left?
		end

		it 'can increment score at start of game' do
			match.new_game
			match.increment_score(player2)
			expect(match.games.last.player_points(player2)).to equal 1
		end

		it 'can increment score mid-game' do
			set_score(4, 7)
			match.increment_score(player2)
			expect(match.games.last.player_points(player1)).to equal 4
			expect(match.games.last.player_points(player2)).to equal 8
		end

		it 'can decrement a player\'s score mid-game' do
			set_score(4, 7)
			match.decrement_score(player1)
			expect(match.games.last.player_points(player1)).to equal 3
			expect(match.games.last.player_points(player2)).to equal 7
		end

		it 'can increment from 10-7 so player1 wins game and new game starts' do
			set_score(10, 7)
			match.increment_score(player1)
			expect(match.games.first.game_winner).to equal player1
			expect(match.games.last.player_points(player1)).to equal 0
		end

		it 'can tell when no player has won yet' do
			set_score(7, 11, 7, 9)
			match.increment_score(player2)
			expect(match.match_winner).to be_nil
		end

		it 'can increment from 7-11, 0-10 so player2 wins match' do
			set_score(7, 11, 6, 10)
			match.increment_score(player2)
			expect(match.match_winner).to equal player2
			expect(match.games.last.player_points(player2)).to equal 11
		end

		it 'can tell how many games a player has won' do
			set_score(7, 11, 11, 6)
			expect(match.games_won(player2)).to equal 1
			expect(match.games_won(player1)).to equal 1
		end

		it 'can tell a player\'s score from a particular game' do
			set_score(3, 11, 2, 4)
			expect(match.game_score(1, player1)).to equal 3
		end

		it 'can tell score of player with most points in a game' do
			set_score(5, 11, 3, 4)
			expect(match.max_points_in_current_game).to equal 4
		end

	end

	context 'Best of 5-game match' do

		let(:match_choices2) { double :match_choices, games_target: 3, 
																									p1_serving?: true, 
																									p1_on_left?: true } 
		let(:match5) { Match.new match_choices2, player1, player2 }

		it 'can tell if match winner in best-of-five match' do
			set_score(7, 11, 7, 11, match5)
			increment(11, match5, player1)
			increment(11, match5, player1)
			increment(10, match5, player2)
			expect(match5.match_winner).to be_nil
			match5.increment_score(player2)
			expect(match5.match_winner).to equal player2
		end

	end

	context 'Decrementing score' do

		it 'decrementing player 2 score at 7-0 in game leaves score unchanged' do
			set_score(3, 11, 7, 0)
			match.decrement_score(player2)
			expect(match.current_game.player_points(player2)).to equal 0
		end

		it 'initial decrement from 0-0 in 2nd game makes current game first game' do
			set_score(3, 11, 0, 0)
			expect(match.games.length).to equal 2
			match.decrement_score(player2)
			expect(match.games.length).to equal 1
		end

		it 'decrementing 2 points from 0-0 in 2nd game reduces '\
																				'player\'s 1st game score by 1' do
			set_score(3, 11, 0, 0)
			match.decrement_score(player2)
			expect(match.current_game.player_points(player2)).to equal 11
			match.decrement_score(player2)
			expect(match.current_game.player_points(player2)).to equal 10
		end	

	end

	context 'Doubles' do

		let(:player_1a) { double :player }
		let(:player_2a) { double :player }

		let(:matchdub) { Match.new(match_choices1,
																player1,
																player_1a,
																player2,
																player_2a) }

		let(:game_choices1) {double :game_choices, server_is_first_partner?: false, 
																							 receiver_is_first_partner?: true}
																							 
		let(:game1) {double :game, game_choices: game_choices1, total_points: 4}

		it 'creates match as doubles match only when initialized with 4 players' do
			expect(match.doubles_match?).to equal false
			expect(matchdub.doubles_match?).to equal true
		end

		it 'can find out which pair is serving' do
			set_score(0, 3, 0, 0, matchdub)
			expect(match_choices1).to receive(:p1_serving?).with(1,3)
			matchdub.server
		end

		it 'can find out which partner of serving pair is serving' do
			matchdub.games << game1
			expect(game_choices1).to receive(:server_is_first_partner?).with(4,true)
			matchdub.server
		end

		it 'will specify which player is serving' do
			matchdub.games << game1
			expect(matchdub.server).to equal player_1a
		end 

		it 'will specify which player is receiving' do
			matchdub.games << game1
			expect(matchdub.doubles_receiver).to equal player2
		end
		
	end

end