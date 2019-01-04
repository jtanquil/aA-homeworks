require "byebug"

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = place_stones
    @name1 = name1
    @name2 = name2
  end

  def place_stones
    Array(0..13).map do |idx|
      val = []
      if idx != 6 && idx != 13
        val = [:stone, :stone, :stone, :stone]
      end

      val
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless start_pos >= 0 && start_pos <= 13 
    raise "Starting cup is empty" unless self.cups[start_pos].length > 0
  end

  def make_move(start_pos, current_player_name)
    player_score_cup = (current_player_name == @name1) ? 6 : 13
    stones = self.cups[start_pos] ? self.cups[start_pos].length : 0
    # debugger
    self.cups[start_pos] = []
    indices = get_indices(stones, start_pos, player_score_cup)

    indices.each do |idx|
      self.cups[idx] << :stone
    end

    render

    next_turn(indices.last, player_score_cup)
  end

  # return indices; skip the opponent's score cup
  def get_indices(stones, array_pos, player_score_cup)
    # debugger
    opp_score_cup = (player_score_cup == 6) ? 13 : 6
    offset = 1
    count = 0
    indices = []

    until count == stones
      if array_pos + offset != opp_score_cup
        indices << (array_pos + offset) % self.cups.length
        count += 1
      end

      offset += 1
    end

    indices
  end

  def next_turn(ending_cup_idx, player_score_cup)
  # 3 cases for the last index:
    # 1) current player's cup => pick another starting position
    # 2) a nonempty cup => go again
    # 3) an empty cup => switch players
    if ending_cup_idx == player_score_cup
      return :prompt
    elsif self.cups[ending_cup_idx].length > 1
      return ending_cup_idx
    elsif self.cups[ending_cup_idx].length == 1
      return :switch
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    first_half = @cups[0..5]
    second_half = @cups[7..12]
    
    first_half_empty = first_half.all? do |cup|
      cup.empty?
    end

    second_half_empty = second_half.all? do |cup|
      cup.empty?
    end

    first_half_empty || second_half_empty
  end

  def winner
    player1_score = self.cups[6].length
    player2_score = self.cups[13].length

    if player1_score > player2_score
      return @name1
    elsif player2_score > player1_score
      return @name2
    else
      return :draw
    end
  end
end
