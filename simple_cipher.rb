# encodes and decodes messages with key that provides shifts
class Cipher
  attr_accessor :key
  ENCODE = 1
  DECODE = -1

  def initialize(key = random_key)
    raise ArgumentError, 'Only lowercase letters' if invalid_key(key)
    @key = key.downcase
  end

  def encode(string)
    string.chars.map.each_with_index do |char, index|
      encode_letter(char, key[mod_index(index)])
    end.join
  end

  def decode(string)
    string.chars.map.each_with_index do |char, index|
      decode_letter(char, key[mod_index(index)])
    end.join
  end

  private

  def random_key
    # get randomly from a - z 100 times
    (1..100).map { ('a'..'z').to_a.sample }.join
  end

  def encode_letter(letter, shift_letter)
    shift(letter, shift_letter, ENCODE)
  end

  def decode_letter(letter, shift_letter)
    shift(letter, shift_letter, DECODE)
  end

  def shift(letter, shift_letter, direction)
    shift_distance = letter_to_number(shift_letter)
    new_value = letter_to_number(letter) + direction * shift_distance
    number_to_letter(new_value)
  end

  def letter_to_number(letter)
    letter.downcase.ord - 'a'.ord
  end

  def number_to_letter(number)
    if number < 0
      number += 26 until number > 0
    elsif number > 0
      number %= 26
    end

    ('a'.ord + number).chr
  end

  def mod_index(index)
    index % key.size
  end

  def invalid_key(key)
    key.match(/[^a-z]/) || key.empty?
  end
end
