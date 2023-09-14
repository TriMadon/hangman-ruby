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

    welcome_message
  end

  def start
    puts "let's get started!"
    @chosen_word = Word.new(random_word)
    @rem_incorr_guesses = 7
    @incorrect_letters = []
  end

  private

  def welcome_message
    puts '╔════════════════════════════════════════════════╗'
    puts '║                   Welcome to                   ║'
    puts '║                    Hangman!                    ║'
    puts "╚════════════════════════════════════════════════╝\n\n"
    puts "Hangman is a word-guessing game. Here's how to play:\n\n"
    puts instructions
  end

  def instructions
    puts <<-INSTRUCTIONS
    1. We'll choose a secret word, and your goal is to guess it letter by letter.
    2. You have 6 incorrect guesses allowed.
    3. Type a letter and press Enter to make a guess.
    4. If you guess a correct letter, it will be revealed in the word.
    5. If you guess an incorrect letter, it will be added to your incorrect letters.
    INSTRUCTIONS
  end

  def load_dictionary
    IO.readlines(DICTIONARY_FILE, chomp: true)
      .filter { |word| word.length <= MAX_WORD_LEN && word.length >= MIN_WORD_LEN }
  end

  def random_word
    @dictionary[(rand * @dictionary.length).ceil]
  end
end
