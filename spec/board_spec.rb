require_relative '../lib/game'
require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  let(:player1) { double(Player, name: 'John', symbol: '⚫') }

end