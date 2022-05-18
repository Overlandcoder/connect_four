require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { double(Board) }

  describe '#play_game' do
    before do
      allow(game).to receive(:game_over?).and_return(true)
      allow(game).to receive(:switch_turns)
    end

    it 'calls #setup' do
      expect(game).to receive(:setup)
      game.play_game
    end
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
    let(:player1) { double(Player, name: 'John', symbol: '⚫') }

    context 'when given a valid move' do
      before do
        allow(game).to receive(:puts)
        game.instance_variable_set(:@current_player, player1)
        allow(game).to receive(:gets).and_return('50')
      end

      it 'returns the input' do
        expect(game.solicit_move).to eq([5, 0])
      end

      it 'does not call #solicit_move again' do
        expect(game).not_to receive(:solicit_move)
      end
    end

    context 'when given an invalid move' do
      before do
        allow(game).to receive(:puts)
        game.instance_variable_set(:@current_player, player1)
        allow(game).to receive(:gets).and_return('60')
      end

      it 'calls #solicit_move again' do
        expect(game).to receive(:solicit_move).once
        game.solicit_move
      end
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