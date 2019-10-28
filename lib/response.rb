require './lib/server'
require './lib/word_search'
require './lib/game'

class Response
  attr_reader :count,
              :hello_count,
              :game

  def initialize
    @count        = 0
    @hello_count  = 0
    @game         = nil
  end

  def increase_count
    @count += 1
  end

  def root(parsed_request)
    increase_count
    parsed_request.diagnostics
  end

  def hello
    increase_count
    @hello_count += 1
    "Hello, World (#{@hello_count})"
  end

  def datetime
    increase_count
    Time.now.strftime("%l:%M%p on %A, %B %e, %Y")
  end

  def shutdown
    increase_count
    "Total Requests: #{@count}"
  end

  def word_search(path)
    increase_count
    word = path.split("=")[1]
    search = WordSearch.new
    search.result(word)
  end

  def get_start_game
    increase_count
    @game = Game.new
    "Good luck!"
  end

  def post_start_game
    increase_count
    "403 Forbidden. Game already in progress."
  end

  def get_game
    increase_count
    @game.game_info
  end

  def post_game(game_input)
    increase_count
    @game.make_guess(game_input)
  end

  def path_not_found
    increase_count
    "404: Path not found."
  end
end
