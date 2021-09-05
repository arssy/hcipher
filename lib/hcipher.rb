# frozen_string_literal: true

require_relative "hcipher/version"
require_relative 'hcipher/cipher'
require "active_support/core_ext/object"
require 'matrix'

module Hcipher
  class Error < StandardError; end
end
