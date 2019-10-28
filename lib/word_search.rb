class WordSearch

  DICTIONARY = File.read("/usr/share/dict/words").split("\n")

  def result(word)
    dict = DICTIONARY
    dict.include?(word)
    if dict.include?(word)
      "#{word} is a known word."
    else
      "#{word} is not a known word."
    end
  end
end
