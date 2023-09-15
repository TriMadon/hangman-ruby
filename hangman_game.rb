# frozen_string_literal: true

require './word'
require 'io/console'

class HangmanGame
  DICTIONARY_FILE = 'dictionary.txt'
  MAX_WORD_LEN = 12
  MIN_WORD_LEN = 5
  NEWGAME = 'n'
  LOAD = 'l'

  def initialize
    @dictionary = load_dictionary
    @secret_word = nil
    @rem_incorr_guesses = nil
    @chosen_letters = nil

    puts welcome_message
  end

  def start
    puts "let's get started!"
    initialize_vars
    main_loop
    puts @secret_word.completed? ? win_message : loss_message
  end

  def initialize_vars
    if user_wants_to_load?
      load_game_from_file
    else
      @secret_word = Word.new(random_word)
      @rem_incorr_guesses = 7
      @chosen_letters = {}
    end
  end

  def user_wants_to_load?
    puts "\nDo you want load the game from a save file? ('y' for yes, anything else to start new game):"
    gets.chomp.strip.downcase == 'y'
  end

  def load_game_from_file
    # implement load here
    puts 'loaded!'
  end

  def main_loop
    until @rem_incorr_guesses.zero? || @secret_word.completed?
      play_a_turn
    end
  end

  def play_a_turn
    puts game_stats
    user_input = prompt_user_for_guess
    process_input(user_input)
    $stdout.clear_screen
  end

  def prompt_user_for_guess
    puts "\nEnter your guess (letter or word): "
    input = ''
    until input_is_valid?(input)
      input = gets.chomp.gsub(/\s+/, '').downcase

      puts 'Invalid input. Please enter a new letter (or full word if you know it)...' unless input_is_valid?(input)
    end
    input
  end

  def input_is_valid?(input)
    return false unless input.length == 1 || input.length == @secret_word.length
    return false unless input =~ /\A[a-z]+\z/
    return false if @chosen_letters.keys.include?(input)

    true
  end

  def process_input(input)
    if input.length == 1
      letter_exists = @secret_word.letter_exists?(input)
      @chosen_letters[input] = letter_exists
      letter_exists ? @secret_word.reveal_letter(input) : @rem_incorr_guesses -= 1
    else
      @secret_word.matches?(input) ? @secret_word.reveal_fully : @rem_incorr_guesses -= 1
    end
  end

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

  def game_stats
    puts "\nIncorrect Guesses Remaining: #{@rem_incorr_guesses}"
    incorrect_letters = @chosen_letters.select { |_, exists| exists == false }.keys
    puts "incorrect Letters: #{incorrect_letters.join(' ')}" unless incorrect_letters.empty?
    puts "\nWord: #{@secret_word}"
  end

  def win_message
    "\nCongratulations! You've guessed the word correctly. It is \"#{@secret_word}\"."
  end

  def loss_message
    @secret_word.reveal_fully
    "\nOut of incorrect guesses! You lost. The word was \"#{@secret_word}\"."
  end

  def load_dictionary
    IO.readlines(DICTIONARY_FILE, chomp: true)
      .filter { |word| word.length <= MAX_WORD_LEN && word.length >= MIN_WORD_LEN }
  end

  def random_word
    @dictionary[(rand * @dictionary.length).ceil]
  end
end
