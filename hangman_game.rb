# frozen_string_literal: true

require './word'

class HangmanGame
  def initialize
    @dictionary = load_dictionary
    @chosen_word = Word.new(random_word)
    @rem_incorr_guesses = 7
    @incorrect_letters = []
  end

  private

  def load_dictionary
    # loads the .txt dictionary into memory
    ['word1', 'word2', 'word3']
  end

  def random_word
    @dictionary[(rand * @dictionary.length).ceil]
  end
end
