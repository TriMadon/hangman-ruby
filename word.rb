# frozen_string_literal: true

class Word
  attr_reader :value

  def initialize(string = '')
    @value = string
    @revealed_letters = []
  end

  def letter_exists?(letter)
    @value.include?(letter)
  end

  def reveal_letter(letter)
    @revealed_letters << letter unless letter_already_revealed?(letter)
  end

  def completed?
    @value.each_char { |letter| return false unless @revealed_letters.include?(letter) }
    true
  end

  def reveal
    @revealed_letters = @value.split('').uniq
  end

  def letter_already_revealed?(letter)
    @revealed_letters.include?(letter)
  end

  def length
    @value.length
  end

  def to_s
    @value.split('').map { |let| @revealed_letters.include?(let) ? let : '_' }.join(' ')
  end
end
