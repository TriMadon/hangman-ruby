# frozen_string_literal: true

class Word
  def initialize(string = '')
    @value = string
    @revealed_letters = []
  end

  def length
    @value.length
  end

  def to_s
    @value.split('').map { |let| @revealed_letters.include?(let) ? let : '_' }.join(' ')
  end
end
