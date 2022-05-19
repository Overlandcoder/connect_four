require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:player1) { double(Player, name: 'John', symbol: '⚫') }

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
        allow(game).to receive(:puts)
        game.instance_variable_set(:@current_player, player1)
        allow(game).to receive(:gets).and_return('1\n')
      end

      it 'stops loop and does not display error message' do
        error_message = 'Invalid input, please enter a number between 1 and 7.'
        expect(game).not_to receive(:puts).with(error_message)
        game.solicit_move
      end
    end

    context 'when given an invalid move' do
      before do
        allow(game).to receive(:puts)
        game.instance_variable_set(:@current_player, player1)
        allow(game).to receive(:gets).and_return('a\n')
      end

      it 'calls #solicit_move again' do
        expect(game).to receive(:solicit_move).once
        game.solicit_move
      end
    end
  end

  describe '#place_token' do
    before do
      allow(game).to receive(:current_player).and_return(player1)
    end

    xit 'places a token' do
      expect()
    end
  end

  describe '#game_over' do
    context 'when board is empty' do
      xit 'is not game over' do
        expect(game).not_to be_game_over
      end
    end
  end
end