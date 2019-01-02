class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless game_over
      round_success_message
      self.sequence_length += 1
    end
  end

  def show_sequence
    add_random_color

    self.seq.each do |color|
      system("clear")
      puts color
      sleep(1)
    end
  end

  def require_sequence
    num_guesses = 0

    until num_guesses == self.sequence_length
      puts "Guess a color: (choices are red, blue, yellow, green)"
      guess = gets.chomp

      unless guess == self.seq[num_guesses]
        self.game_over = true
      end

      num_guesses += 1
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Round successful!"
  end

  def game_over_message
    puts "Game over!"
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
  end
end
