class Tile
    attr_accessor :has_mine, :status

    def initialize(has_mine = False, status = :hidden)
        @has_mine = has_mine
        @status = status
    end

    def to_s(adjacent_mines = nil)
        return adjacent_mines.to_s if adjacent_mines
        
        if self.status == :hidden
            return "H"
        elsif self.status == :flagged
            return "F"
        elsif self.status == :revealed
            return (self.has_mine) ? "M" : "E"
        end
    end
end