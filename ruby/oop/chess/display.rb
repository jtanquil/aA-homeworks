require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"

class Display
    attr_reader :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0, 0], self.board)
    end

    def render
        puts "  a b c d e f g h"
        self.board.rows.each_with_index do |row, idx1|
            row_string = row.map.with_index do |ele, idx2|
                ele_str = (ele) ? ele.to_s : " "
                (idx1 == self.cursor.cursor_pos[0] && idx2 == self.cursor.cursor_pos[1]) ? ele_str.colorize(:background => :green) : ele_str
            end

            puts (idx1 + 1).to_s + " " + row_string.join(" ")
        end

        nil
    end

    def run
        while true
            render
            self.cursor.get_input
        end
    end
end