# Crap I didn't do well at first on

* Read the specs carefully
* Start taking notes first
* Have a rough draft of the description of the specs
  * Read through specs and then the tests if they are provided
  * try to identify requirements
* fine tune it afterward
  * extract objects and methods from description
  * actually copy and paste text as you are implementing it
* it's ok to not know implementation right off the bat

* I DO need to get a high level of proficiency with the material
  * Look up: `each_with_object`

# Comparing and improving my implementation

* Overall, I'm pretty similar to the solutions!  :)
* loop through key with the % operator
* label 'magic' numbers, ie ENCODE = 1, DECODE = -1

# My Changes

## Before

~~~ ruby

def extend_key(string)
  extended_key = key
  loop do
    break if extended_key.size > string.size
    extended_key += key
  end
  @key = extended_key
end
~~~

## After

~~~ ruby

def key_index(index)
  index % key.size
end
~~~

## Analysis

* Instead of duplicating the key over and over and over, I can just operate on the
  index.  SO, much simpler!
* From the video, Kevin said that the idea of a message longer then the key
  wasn't even in the specs.  I didn't think that this was important

## Before

* I'm converting letters to numbers, adding or subtracting, then converting
  back to letters
  * `letter_to_number`:

~~~ ruby

def letter_to_number(letter)
  letter.downcase.ord - 'a'.ord
end
~~~

  * `number_to_letter`:

~~~ ruby

def number_to_letter(number)
  reduced_number = number % 26

  ('a'.ord + reduced_number).chr
end
~~~

  * `shift(number, size)`:

~~~ ruby

def shift(number, size)
  if size < 0
    (number + (26 + size)) % 26
  else
    (number + size) % 26
  end
end
~~~

* my `encode` has lots of blocks and what not:

~~~ ruby

def encode(string)
  string.chars.map { |char| letter_to_number(char) }
        .each_with_index
        .map { |number, index| number + letter_to_number(key[mod_index(index)]) }
        .map { |number| number_to_letter(number) }.join
end
~~~

* What if I just made a method that worked with letters right off the bat?

~~~ ruby

def shift(start_letter, shift_letter)
  ...
end
~~~


## After

~~~ ruby

def shift_letter(start_letter, shift_letter)
end
~~~

* encode is a lot simpler...

~~~ ruby

def encode(string)
  string.chars.map.each_with_index
        { |char, index| shift_letter(char, key[mod_index(index)]) }
        .join
end
~~~

## Analysis

* I don't like the chain of method calls even through the blocks are reduced.
  * `string.chars.map.each_with_index`
* like having `encode_letter` and `decode_letter` even though we can dry it up
  a bit by just having `shift_letter`

## Conclusion

* I like cleaning up the code by changing the complex `extend_code` thing
* I can probably work on the `encode` and `decode` functionality/smell

