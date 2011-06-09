require 'fileutils'

dir = File.expand_path(File.dirname(File.dirname(__FILE__)))

$FAKE_ROOT = File.join(dir, 'fixtures/fakeroot/')

# 
ENV['HOME']            = $FAKE_ROOT + 'home'
ENV['XDG_DATA_HOME']   = $FAKE_ROOT + '.local/share'
ENV['XDG_DATA_DIRS']   = $FAKE_ROOT + 'usr/share'
ENV['XDG_CONFIG_HOME'] = $FAKE_ROOT + '.config'
ENV['XDG_CONFIG_DIRS'] = $FAKE_ROOT + 'etc/xdg'
ENV['XDG_CACHE_HOME']  = $FAKE_ROOT + '.cache'
ENV['XDG_CACHE_DIRS']  = $FAKE_ROOT + 'tmp'

