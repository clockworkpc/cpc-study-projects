require 'base64'
module Codewars
  class MorseCode
    ALPHABET = {
      '0' => '-----',
      '1' => '.----',
      '2' => '..---',
      '3' => '...--',
      '4' => '....-',
      '5' => '.....',
      '6' => '-....',
      '7' => '--...',
      '8' => '---..',
      '9' => '----.',
      'A' => '.-',
      'B' => '-...',
      'C' => '-.-.',
      'D' => '-..',
      'E' => '.',
      'F' => '..-.',
      'G' => '--.',
      'H' => '....',
      'I' => '..',
      'J' => '.---',
      'K' => '-.-',
      'L' => '.-..',
      'M' => '--',
      'N' => '-.',
      'O' => '---',
      'P' => '.--.',
      'Q' => '--.-',
      'R' => '.-.',
      'S' => '...',
      'T' => '-',
      'U' => '..-',
      'V' => '...-',
      'W' => '.--',
      'X' => '-..-',
      'Y' => '-.--',
      'Z' => '--..',
      '.' => '.-.-.-',
      ',' => '--..--',
      '?' => '..--..',
      '!' => '-.-.--',
      '-' => '-....-',
      '/' => '-..-.',
      '@' => '.--.-.',
      '(' => '-.--.',
      ')' => '-.--.-',
      'SOS' => '...---...'
    }

    def decode_morse(morse_code)
      res = morse_code.split('   ').each_with_object([]) do |word, ary|
        word.split.each { |chars| ary << ALPHABET.key(chars.downcase) }
        ary << ' '
      end

      res.join.strip
    end

    def decodeMorse(morseCode)
      decode_morse(morseCode)
    end
  end
end
