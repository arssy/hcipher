module Hcipher
  class Cipher
    # define characters here
    # below is default defined characters
    CHARS = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.:;?/\\'\"()<>[]{}|`~!@#$%^&*-_=+".split("").freeze

    # generate key
    # only integer is allowed as parameter
    # sending n as parameter will create n*n matrix
    # determinant from matrix created must not 0
    # matrix created will be converted to string
    def self.generate_key(size)
      raise ArgumentError.new("Only integer are allowed") unless size.is_a?(Integer)
      matrix_key = []
      loop do
        matrix_key = Matrix.build(size) { rand(1..(CHARS.size - 1)) }
        coprime = ((matrix_key.det).gcd(CHARS.size) == 1)

        # always break unless determinant matrix == 0 or determinant matrix and characters size not coprime
        break unless matrix_key.det == 0 || !coprime
      end
      matrix_to_str(matrix_key)
    end

    def self.encrypt(text, key)
      # Validation
      raise ArgumentError.new("Text and key can not be nil") unless text.present? && key.present?
      check_characters(text)
      check_characters(key)
      check_string(text)
      check_string(key)
      check_key(key)

      # get matrix for key and text
      matrix_key, matrix_text = get_matrix(text, key)

      # encrypt text
      encrypted_matrix = matrix_key * matrix_text
      encrypted_matrix = encrypted_matrix.map{|x| x % CHARS.size}
      encrypted_text = matrix_to_str(encrypted_matrix)
    end

    def self.decrypt(text, key)
      # Validation
      raise ArgumentError.new("Text and key can not be nil") unless text.present? && key.present?
      check_characters(text)
      check_characters(key)
      check_string(text)
      check_string(key)
      check_key(key)

      # get matrix for key and text
      matrix_key, matrix_text = get_matrix(text, key)
      matrix_key = decryption_key_matrix(matrix_key)

      # decrypt text
      decrypted_matrix = matrix_key * matrix_text
      decrypted_matrix = decrypted_matrix.map{|x| x % CHARS.size}
      decrypted_text = matrix_to_str(decrypted_matrix)
    end

    private
    def self.get_matrix(text, key)
      # create matrix key
      sqrt_key_size = Math.sqrt(key.size).to_i
      matrix_key = generate_matrix(key, sqrt_key_size, sqrt_key_size)

      # create matrix text
      column = (text.size/sqrt_key_size.to_f).ceil
      matrix_text = generate_matrix(text, sqrt_key_size, column)
      return matrix_key, matrix_text
    end

    def self.generate_matrix(string, rows, cols)
      # scenario: rows x cols == 2 x 2 but the string provided have 3 characters
      # If scenario similar to above happen, the index that can't be filled will be filled automatically with 0
      # ex: [[1, 2], [3, 0]]
      Matrix.build(rows, cols){|row, col| ((cols * row) + col) >= string.size ? 0 : CHARS.rindex(string[(cols * row) + col])}
    end

    def self.decryption_key_matrix(matrix)
      det_inv = 0
      det = matrix.det % CHARS.size
      loop do 
        det_inv += 1
        break if ((det * det_inv) % CHARS.size) == 1
      end
      
      matrix_inv = matrix.adjugate.map{|x| ((x % CHARS.size) * det_inv) % CHARS.size}
    end

    # convert matrix to string
    def self.matrix_to_str(matrix)
      str = ""
      matrix.each do |num|
        # next if num == 0
        str << CHARS[num]
      end
      str
    end

    def self.check_key(key)
      # Math.sqrt() return float type. ex: 3.0
      # Set key as invalid if square root of key size is not an integer
      raise ArgumentError.new("Key not valid") unless Math.sqrt(key.size).to_s.split(".").last.to_f == 0
    end

    def self.check_string(string)
      # Allowed key and text type is string
      raise ArgumentError.new("Only string are allowed") unless string.is_a?(String)
    end

    # return error message if character not defined
    def self.check_characters(string)
      valid = string.to_s.split("").map{|char| CHARS.include?(char)}.uniq rescue false
      raise ArgumentError.new("Some characters are not defined, please define the character first") unless valid.size == 1 && valid.first == true
    end
  end
end