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
  end

  def make_move(start_pos, current_player_name)
    array_pos = (start_pos <= 6) ? start_pos - 1 : start_pos
    player_score_cup = (current_player_name == @name1) ? 6 : 13
    stones = self.cups[array_pos].length
    self.cups[array_pos] = []
    indices = get_indices(stones, array_pos, player_score_cup)

    indices.each do |idx|
      self.cups[indices] << :stone
    end

    # 3 cases for the last index:
    # 1) current player's cup => pick another starting position
    # 2) a nonempty cup => go again
    # 3) an empty cup => switch players
    if indices.last == player_score_cup
      return :prompt
    elsif self.cups[indices.last].length > 1
      return indices.last
    else
      return :switch
    end
  end

  # return indices; skip the opponent's score cup
  def get_indices(stones, array_pos, player_score_cup)
    opp_score_cup = (player_score_cup == 6) ? 13 : 6
    offset = 1
    count = 0
    indices = []

    until count == stones
      if array_pos + offset != opp_score_cup
        indices << array_pos + offset
        count += 1
      end

      offset += 1
    end

    indices
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
