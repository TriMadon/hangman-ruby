# frozen_string_literal: true

require './word'

class HangmanGame
  DICTIONARY_FILE = 'dictionary.txt'

  def initialize
    @dictionary = load_dictionary
    @chosen_word = Word.new(random_word)
    @rem_incorr_guesses = 7
    @incorrect_letters = []
  end

  def start
    # starting logic here
  end

  private

  def load_dictionary
    # loads the .txt dictionary into memory
    IO.readlines(DICTIONARY_FILE, chomp: true)
  end

  def random_word
    @dictionary[(rand * @dictionary.length).ceil]
  end
end
