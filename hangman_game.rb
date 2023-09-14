# frozen_string_literal: true

require './word'

class HangmanGame
  DICTIONARY_FILE = 'dictionary.txt'
  MAX_WORD_LEN = 12
  MIN_WORD_LEN = 5

  def initialize
    @dictionary = load_dictionary
    @chosen_word = nil
    @rem_incorr_guesses = nil
    @incorrect_letters = nil
  end

  def start
    @chosen_word = Word.new(random_word)
    @rem_incorr_guesses = 7
    @incorrect_letters = []
  end

  private

  def load_dictionary
    IO.readlines(DICTIONARY_FILE, chomp: true)
      .filter { |word| word.length <= MAX_WORD_LEN && word.length >= MIN_WORD_LEN }
  end

  def random_word
    @dictionary[(rand * @dictionary.length).ceil]
  end
end
