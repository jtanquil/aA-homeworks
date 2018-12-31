require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end
  
  # assuming: 
  # "player" = @next_mover_mark
  # "current turn" = evaluator
  def losing_node?(evaluator)
    if self.board.over?
      if self.board.winner && self.board.winner != evaluator
        return true
      else
        return false
      end
    else
      if self.next_mover_mark == evaluator
        return self.children.all? { |next_move| next_move.losing_node?(evaluator) }
      else
        return self.children.any? { |next_move| next_move.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    if self.board.over?
      if self.board.winner == evaluator
        return true
      else 
        return false
      end
    else
      if self.next_mover_mark == evaluator
        return self.children.any? { |next_move| next_move.winning_node?(evaluator) }
      else
        return self.children.all? { |next_move| next_move.winning_node?(evaluator) }
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_nodes = []

    [0, 1, 2].each do |row|
      [0, 1, 2].each do |col|
        pos = [row, col]

        if self.board.empty?(pos)
          new_board = self.board.dup
          new_board[pos] = self.next_mover_mark
          new_next_mover = (self.next_mover_mark == :x) ? :o : :x
          new_node = TicTacToeNode.new(new_board, new_next_mover, pos)

          child_nodes << new_node
        end
      end
    end

    child_nodes
  end
end
