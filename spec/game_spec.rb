require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#play_game' do
    it 'calls #setup' do
      expect(game).to receive(:setup)
      game.play_game
    end
  end

  describe '#create_player' do
    context 'when creating player 1' do
      before do
        allow(game).to receive(:gets).and_return('John')
      end

      it 'creates player 1 with the right parameters' do
        symbol = game.symbol
        expect(Player).to receive(:new).with('John', '⚫')
        game.create_player(1)
      end
    end
  end
end