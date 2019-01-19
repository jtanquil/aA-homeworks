require "colorize"

class Piece
    attr_accessor :color

    def initialize(color)
        @color = color
    end

    def to_s
        (self.color == :b) ? "P".blue : "P".white
    end
end