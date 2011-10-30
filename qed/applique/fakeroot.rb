require 'fileutils'

dir = File.expand_path(File.dirname(File.dirname(__FILE__)))

$froot = File.join(dir, 'fixtures/fakeroot/')

puts "Fake root at: `#{$froot}'."

#
ENV['HOME']            = $froot + 'home/joe'
#ENV['XDG_DATA_HOME']   = $froot + '.local/share'
ENV['XDG_DATA_DIRS']   = $froot + 'usr/share'
#ENV['XDG_CONFIG_HOME'] = $froot + '.config'
ENV['XDG_CONFIG_DIRS'] = $froot + 'etc/xdg' + ':' + $froot + 'etc'
#ENV['XDG_CACHE_HOME']  = $froot + '.cache'
ENV['XDG_CACHE_DIRS']  = $froot + 'tmp'

