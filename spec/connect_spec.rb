require_relative '../lib/connect'
describe ConnectFour do
  subject(:game_board) { described_class.new }
  context 'board changing methods' do
    describe '#layout' do
      it "gets the empty board when the pieces are '_'" do
        pieces = game_board.board_pieces
        result = game_board.layout
        layout = '| _ | _ | _ | _ | _ | _ | _ |
| _ | _ | _ | _ | _ | _ | _ |
| _ | _ | _ | _ | _ | _ | _ |
| _ | _ | _ | _ | _ | _ | _ |
| _ | _ | _ | _ | _ | _ | _ |
| _ | _ | _ | _ | _ | _ | _ |'
        expect(result.strip).to eq(layout.strip)
      end
    end
    describe '#make_move' do
      it 'puts the piece on the first row of that column' do
        pieces = game_board.board_pieces
        expect { game_board.make_move(pieces, 0, 'x') }.to change { game_board.board_pieces[0][0] }.to('x')
      end
      it 'puts the piece on the second row of that column' do
        game_board.board_pieces[0][0] = 'x'
        pieces = game_board.board_pieces
        expect { game_board.make_move(pieces, 0, 'x') }.to change { game_board.board_pieces[1][0] }.to('x')
      end
      it 'alarms on impossible moves' do
        pieces = Array.new(6) { Array.new(7, 'x') }
        expect(game_board.make_move(pieces, 0, 'x')).to eq("Can't make this move!")
      end
    end
  end
  describe '#check_winner' do
    it "returns false when there's no winner" do
      expect(game_board.check_winner(game_board.board_pieces)).to eq(false)
    end
    it "returns 'red' when red wins" do
      game_board.board_pieces[3][0] = "\u{1F534}"
      game_board.board_pieces[1][0] = "\u{1F534}"
      game_board.board_pieces[2][0] = "\u{1F534}"
      game_board.board_pieces[0][0] = "\u{1F534}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F534}")
    end
    it "returns 'yellow' when yellow wins" do
      game_board.board_pieces[3][0] = "\u{1F7E1}"
      game_board.board_pieces[1][0] = "\u{1F7E1}"
      game_board.board_pieces[2][0] = "\u{1F7E1}"
      game_board.board_pieces[0][0] = "\u{1F7E1}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F7E1}")
    end
    it "returns 'yellow' when yellow wins vertically" do
      game_board.board_pieces[3][0] = "\u{1F7E1}"
      game_board.board_pieces[1][0] = "\u{1F7E1}"
      game_board.board_pieces[2][0] = "\u{1F7E1}"
      game_board.board_pieces[0][0] = "\u{1F7E1}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F7E1}")
    end
    it "returns 'yellow' when yellow wins horizontally" do
      game_board.board_pieces[0][3] = "\u{1F7E1}"
      game_board.board_pieces[0][2] = "\u{1F7E1}"
      game_board.board_pieces[0][1] = "\u{1F7E1}"
      game_board.board_pieces[0][0] = "\u{1F7E1}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F7E1}")
    end
    it "returns 'yellow' when yellow wins on an upward diagonal" do
      game_board.board_pieces[0][0] = "\u{1F7E1}"
      game_board.board_pieces[1][1] = "\u{1F7E1}"
      game_board.board_pieces[2][2] = "\u{1F7E1}"
      game_board.board_pieces[3][3] = "\u{1F7E1}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F7E1}")
    end
    it "returns 'yellow' when yellow wins on a downward diagonal" do
      game_board.board_pieces[0][3] = "\u{1F7E1}"
      game_board.board_pieces[1][2] = "\u{1F7E1}"
      game_board.board_pieces[2][1] = "\u{1F7E1}"
      game_board.board_pieces[3][0] = "\u{1F7E1}"
      expect(game_board.check_winner(game_board.board_pieces)).to eq("\u{1F7E1}")
    end
  end
end