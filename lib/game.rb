class Game
  attr_reader :current_guess,
              :guess_count

  def initialize
    @number         = rand(0..100)
    @guess_count    = 0
    @current_guess  = 0
  end

  def valid_guess?(guess)
    true if guess.to_i.to_s == guess
  end

  def make_guess(guess)
    if valid_guess?(guess)
      @guess_count += 1
      @current_guess = guess.to_i
      return guess_evaluation if @current_guess == @number
      "Guess again."
    else
      @current_guess = "Invalid input"
    end
  end

  def game_info
    "You have made #{@guess_count} guesses. #{guess_evaluation}"
  end

  def guess_evaluation
    if valid_guess?("#{@current_guess}")
      if @current_guess > @number
        "#{@current_guess.to_i} is greater than the number."
      elsif @current_guess < @number
        "#{@current_guess} is less than the number."
      else
        "#{@current_guess} is correct!"
      end
    end
  end
end
