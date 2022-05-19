require_relative '../lib/game'
require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  
  describe '#place_token' do
    context 'when column is empty' do
      it 'places a token in the bottom slot' do
        board.place_token(1, "x")
        expect(board.board[5][0]).to eq('x')
      end

      it 'does not place tokens in the entire column' do
        board.place_token(1, "x")
        expect(board.board[4][0]).to be nil
      end
    end

    context 'when column has 1 slot filled' do
      it 'places a token in the second-last slot from the bottom' do
        board.place_token(1, "o")
        board.place_token(1, "o")
        expect(board.board[4][0]).to eq('o')
      end

      it 'leaves the third-last slot empty' do
        board.place_token(1, "o")
        board.place_token(1, "o")
        expect(board.board[3][0]).to be nil
      end
    end
  end
end