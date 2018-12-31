require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    game_tree = TicTacToeNode.new(game.board, mark)
    possible_moves = game_tree.children

    # first, find a winning move
    # if no such move is found, pick a non-losing move
    # if there are no non-losing nodes, raise an error
    possible_moves.each do |move|
      if move.winning_node?(mark)
        return move.prev_move_pos
      end
    end

    possible_moves.each do |move|
      if !move.losing_node?(mark)
        return move.prev_move_pos
      end
    end

    raise "There should be a non-losing move!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
