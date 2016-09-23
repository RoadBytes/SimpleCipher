
* I tried to dry up my `encode_letter` and `decode_letter` methods

## Before

~~~ ruby

  def encode_letter(letter, shift_letter)
    shift_distance = letter_to_number(shift_letter)
    new_value = letter_to_number(letter) + shift_distance
    number_to_letter(new_value)
  end

  def decode_letter(letter, shift_letter)
    shift_distance = letter_to_number(shift_letter)
    new_value = letter_to_number(letter) +  (26 - shift_distance)
    number_to_letter(new_value)
  end

  def number_to_letter(number)
    reduced_number = number % 26

    ('a'.ord + reduced_number).chr
  end
~~~

## After

~~~ ruby

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

  def number_to_letter(number)
    if number < 0
      number += 26 until number > 0
    elsif number > 0
      number %= 26
    end

    ('a'.ord + number).chr
  end
~~~

## Analysis

* I think this edit is not necessarily better since it's longer
* BUT, I liked how it tries to simplify the implementation of the shift
  * `new_value = letter_to_number(letter) +  (26 - shift_distance)`
    doesn't make as much sense as...
  * `new_value = letter_to_number(letter) + direction * shift_distance`
* Personally, one of the things I need to work on is having a DETAILED HIGH
  level working of the specs FIRST before coding, bc that would help clear up a
  lot of the implementation confusion with some of the methods.
