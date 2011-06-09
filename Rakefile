#!/usr/bin/env ruby

require 'rake/testtask'

#
def command?(command)
  system("type #{command} > /dev/null 2>&1")
end

#
# Tests
#

task :default => [:qed, :test]

if command? :turn
  desc "Run tests"
  task :test do
    suffix = "-n #{ENV['TEST']}" if ENV['TEST']
    sh "turn -Ilib:. test/*.rb #{suffix}"
  end
else
  Rake::TestTask.new do |t|
    t.libs << 'lib'
    t.libs << '.'
    t.pattern = 'test/test_*.rb'
    t.verbose = false
  end
end

if command? :qed
  desc "run qed tests"
  task :qed do
    sh "qed -Ilib qed/"
  end
else
  task :qed do
    $stderr.puts "WARNING: install qed gem to run qed tests"
  end
end

