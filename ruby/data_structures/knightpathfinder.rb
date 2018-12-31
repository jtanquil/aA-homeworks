require_relative "./skeleton/lib/00_tree_node.rb"

# override default inspect behavior to examine move tree
class PolyTreeNode
    def inspect
        if @children.length == 0
            @value.inspect
        else
            @children
        end
    end
end

class KnightPathFinder
    attr_reader :root_node, :considered_positions, :move_tree

    def initialize(starting_position)
        @root_node = PolyTreeNode.new(starting_position)
        @considered_positions = Set[starting_position]
        @move_tree = self.build_move_tree
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

    def build_move_tree
        move_tree = self.root_node

        # bfs algorithm to build the move tree
        queue = [move_tree]

        until queue.empty?
            head = queue.shift

            # add children to the queue to explore
            # will eventually terminate due to considered_positions
            self.new_move_positions(head.value).each do |pos|
                new_child = PolyTreeNode.new(pos)
                head.add_child(new_child)
                queue << new_child
            end
        end

        move_tree
    end
end