require "colorize"

class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s2
        (self.color == :b) ? "P".blue : "P".white
    end
end