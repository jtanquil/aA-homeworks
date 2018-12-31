require_relative "./skeleton/lib/00_tree_node.rb"

class KnightPathFinder
    attr_reader :root_node, :considered_positions

    def initialize(starting_position)
        @root_node = PolyTreeNode.new(starting_position)
        @considered_positions = Set[starting_position]
    end

    def self.valid_moves(pos)
        row, col = pos
        possible_moves = []

        # TODO: enumerate on [+-1, +-2]?
        [1, 2].each do |idx|
            possible_moves += [[row + idx, col + (3 - idx)],
                               [row - idx, col - (3 - idx)],
                               [row + idx, col - (3 - idx)],
                               [row - idx, col + (3 - idx)]]
        end

        possible_moves.select do |ele|
            ele.all? { |coord| coord >= 0 && coord <= 7 }
        end
    end

    def new_move_positions(pos)
        possible_positions = KnightPathFinder.valid_moves(pos).reject do |ele|
            self.considered_positions.include?(ele)
        end

        possible_positions.each { |ele| self.considered_positions << ele }
    end
end