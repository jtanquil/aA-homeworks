require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"

class Display
    attr_reader :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0, 0], self.board)
    end

end