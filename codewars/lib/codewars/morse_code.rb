require 'base64'
module Codewars
  class MorseCode
    def decode_bits(bits)
      Base64.decode64(bits)
    end

    def decode_morse(morse_code)
    end
  end
end
