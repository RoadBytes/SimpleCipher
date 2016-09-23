# encodes and decodes messages with key that provides shifts
class Cipher
  attr_accessor :key

  def initialize(key = random_key)
    raise ArgumentError, 'Only lowercase letters' if invalid_key(key)
    @key = key.downcase
  end

  def encode(string)
    extend_key(string)

    string.chars.map { |char| letter_to_number(char) }
          .each_with_index
          .map { |number, index| number + letter_to_number(key[index]) }
          .map { |number| number_to_letter(number) }.join
  end

  def decode(string)
    extend_key(string)

    string.chars.map { |char| letter_to_number(char) }
          .each_with_index
          .map { |number, index| number - letter_to_number(key[index]) }
          .map { |number| number_to_letter(number) }.join
  end

  private

  def random_key
    # get randomly from a - z 100 times
    (1..100).map { ('a'..'z').to_a.sample }.join
  end

  def letter_to_number(letter)
    letter.downcase.ord - 'a'.ord
  end

  def number_to_letter(number)
    reduced_number = number % 26

    ('a'.ord + reduced_number).chr
  end

  def shift(number, size)
    if size < 0
      (number + (26 + size)) % 26
    else
      (number + size) % 26
    end
  end

  def extend_key(string)
    extended_key = key
    loop do
      break if extended_key.size > string.size
      extended_key += key
    end
    @key = extended_key
  end

  def invalid_key(key)
    key.match(/[^a-z]/) || key.empty?
  end
end
