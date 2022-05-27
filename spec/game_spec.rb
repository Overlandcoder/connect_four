require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:player1) { double(Player, name: 'John', symbol: '⚫') }
  let(:board) { double(Board) }

  describe '#play_game' do
  end

  describe '#create_player' do
    context 'when creating player 1' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('John')
      end

      it 'creates player 1 with the right parameters' do
        expect(Player).to receive(:new).with('John', '⚫')
        game.create_player(1)
      end
    end

    context 'when creating player 2' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Jane')
      end

      it 'creates player 2 with the right parameters' do
        expect(Player).to receive(:new).with('Jane', '⚪')
        game.create_player(2)
      end
    end
  end

  describe '#solicit_move' do
    context 'when given a valid move' do
      before do
        allow(game).to receive(:gets).and_return('1\n')
      end

      it 'stops loop and does not display error message' do
        error_message = 'Invalid input, please enter a number between 1 and 7.'
        expect(game).not_to receive(:puts).with(error_message)
        game.solicit_move
      end
    end

    context 'when given an invalid move once, then a valid move' do
      before do
        letter = 'a'
        valid_input = '3'
        allow(game).to receive(:gets).and_return(letter, valid_input)
      end

      it 'completes loop and displays error message once' do
        error_message = 'Invalid input, please enter a number between 1 and 7.'
        expect(game).to receive(:puts).with(error_message).once
        game.solicit_move
      end
    end

    context 'when given an invalid move twice, then a valid move' do
      before do
        letter = 'a'
        large_num = '100'
        valid_input = '1'
        allow(game).to receive(:gets).and_return(letter, large_num, valid_input)
      end

      it 'completes loop and displays error message twice' do
        error_message = 'Invalid input, please enter a number between 1 and 7.'
        expect(game).to receive(:puts).with(error_message).twice
        game.solicit_move
      end
    end
  end

  describe '#play_game' do
    context 'when #board.full? is false four times' do
      before do
        allow(game).to receive(:setup)
        allow(game).to receive(:current_player).and_return(player1)
        allow(game).to receive(:gets).and_return('1\n')
        allow(board).to receive(:full?).and_return(false, false, false, false, true)
      end

      it 'calls #switch_turns four times' do
        allow(board).to receive(:display)
        expect(game).to receive(:switch_turns).exactly(4).times
        game.play_game
      end

      it 'calls #prompt_player four times' do
        allow(board).to receive(:display)
        expect(game).to receive(:prompt_player).exactly(4).times
        game.play_game
      end

      xit 'calls #solicit_move four times' do
        expect(game).to receive(:solicit_move).exactly(4).times
        game.play_game
      end

      xit 'sends #place_token to board' do
        allow(game).to receive(:solicit_move).and_return(1)
        expect(board).to receive(:place_token).with(1, '⚫').exactly(4).times
        game.play_game
      end

      xit 'sends #display to board' do
        expect(board).to receive(:display).exactly(4).times
        game.play_game
      end
    end
  end
end