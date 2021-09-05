# frozen_string_literal: true

RSpec.describe Hcipher do
  it "has a version number" do
    expect(Hcipher::VERSION).not_to be nil
  end

  # Test suite for character list
  describe 'character list' do
    it 'should not empty' do
      expect(Hcipher::Cipher.characters).not_to be_nil
    end

    it 'should return characters list' do
      expect(Hcipher::Cipher.characters).to be_a(Array)
    end
  end

  # Test suite for generate key
  describe 'generate key' do
    let(:size) { 3 }

    it 'should generate string with length n*n' do
      expect(Hcipher::Cipher.generate_key(size).size).to eql(size*size)
    end

    it 'should accept one parameter' do
      expect{Hcipher::Cipher.generate_key}.to raise_error(ArgumentError)
    end

    it 'should only accept integer as parameter' do
      expect{Hcipher::Cipher.generate_key('a')}.to raise_error(ArgumentError, "Only integer are allowed")
    end
  end

  # Test suite for encrypt
  describe 'encrypt' do
    let(:text) {"Plain text"}
    let(:key) {Hcipher::Cipher.generate_key(3)}

    it 'should return an encrypted text' do
      expect(Hcipher::Cipher.encrypt(text, key)).not_to eql(text)
    end

    it 'should return error message if characters not defined' do
      text = "☹"
      expect{Hcipher::Cipher.encrypt(text, key)}.to raise_error(ArgumentError, "Some characters are not defined, please define the character first")
    end

    it 'should accept 2 parameter' do
      expect{Hcipher::Cipher.encrypt}.to raise_error(ArgumentError)
    end

    it 'should have text' do
      expect{Hcipher::Cipher.encrypt(nil, key)}.to raise_error(ArgumentError, "Text and key can not be nil")
    end

    it 'should have key' do
      expect{Hcipher::Cipher.encrypt(text, nil)}.to raise_error(ArgumentError, "Text and key can not be nil")
    end

    it 'should have valid key' do
      key = "123"
      expect{Hcipher::Cipher.encrypt(text, key)}.to raise_error(ArgumentError, "Key not valid")
    end

    it 'should return error message if parameter not string' do
      matrix = [1, 2]
      expect{Hcipher::Cipher.encrypt(matrix, matrix)}.to raise_error(ArgumentError, "Only string are allowed")
    end
  end

  # Test suite for decrypting
  describe 'decrypting' do
    let(:text) {"Plain text"}
    let(:key) {Hcipher::Cipher.generate_key(3)}
    let(:encrypted_text) {Hcipher::Cipher.encrypt(text, key)}
    
    it 'should return the decrypted text' do
      expect(Hcipher::Cipher.decrypt(encrypted_text, key)).to match(/^#{text}/)
    end

    it 'should return error message if characters not defined' do
      text = "☹"
      expect{Hcipher::Cipher.decrypt(text, key)}.to raise_error(ArgumentError, "Some characters are not defined, please define the character first")
    end

    it 'should accept 2 parameter' do
      expect{Hcipher::Cipher.decrypt}.to raise_error(ArgumentError)
    end

    it 'should have text' do
      expect{Hcipher::Cipher.decrypt(nil, key)}.to raise_error(ArgumentError, "Text and key can not be nil")
    end

    it 'should have key' do
      expect{Hcipher::Cipher.decrypt(encrypted_text, nil)}.to raise_error(ArgumentError, "Text and key can not be nil")
    end

    it 'should have valid key' do
      key = "123"
      expect{Hcipher::Cipher.decrypt(encrypted_text, key)}.to raise_error(ArgumentError, "Key not valid")
    end

    it 'should return error message if parameter not string' do
      matrix = [1, 2]
      expect{Hcipher::Cipher.decrypt(matrix, matrix)}.to raise_error(ArgumentError, "Only string are allowed")
    end
  end
end
