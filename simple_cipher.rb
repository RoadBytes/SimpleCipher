class Cipher
  def initialize(input = '')
  end

  def encode(string)
    string.chars.map { |char| letter_to_number(char) }
          .map { |number| shift(number, 3) }
          .map { |number| number_to_letter(number) }.join
  end

  def decode(string)
    string.chars.map { |char| letter_to_number(char) }
          .map { |number| shift(number, -3) }
          .map { |number| number_to_letter(number) }.join
  end

  def letter_to_number(letter)
    letter.downcase.ord - 'a'.ord
  end

  def number_to_letter(number)
    ('a'.ord + number).chr
  end

  def shift(number, size)
    if size < 0
      (number + (26 + size)) % 26
    else
      (number + size) % 26
    end
  end
end
