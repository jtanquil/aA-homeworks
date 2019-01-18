require_relative "piece"

class Board
    attr_reader :rows

    def initialize
        @rows = create_board
        # @sentinel = NullPiece.new
    end

    def create_board
        board = Array.new(8) { Array.new }
        board.each_with_index do |row, idx|
            if idx < 2 || idx > 5
                8.times { row << Piece.new }
            else
                8.times { row << nil }
            end
        end
        board
    end

    def [](pos)
        row, col = pos
        self.rows[row][col]
    end

    def []=(pos, val)
        row, col = pos
        self.rows[row][col] = val
    end

    def move_piece(start_pos, end_pos)
        raise "No piece at the starting position!" unless self[start_pos]
        raise "End position is invalid!" unless valid_pos(end_pos)

        self[end_pos] = self[start_pos]
        self[start_pos] = nil
    end

    def valid_pos(pos)
        true
    end
end