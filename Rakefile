# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "hcipher"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :hcipher do
  desc "Generate a key for hill cipher"
  task :generate_key, [:size] do |t, args|
    puts Hcipher::Cipher.generate_key(args[:size].to_i)
  end
end