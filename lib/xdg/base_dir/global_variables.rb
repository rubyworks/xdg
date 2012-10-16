if RUBY_VERSION > '1.9'
  require_relative 'base_dir'
else
  require 'xdg/base_dir'
end

$XDG_DATA        = XDG::BaseDir.new('DATA')
$XDG_DATA_HOME   = XDG::BaseDir.new('DATA', 'HOME')
$XDG_DATA_DIRS   = XDG::BaseDir.new('DATA', 'DIRS')

$XDG_CONFIG      = XDG::BaseDir.new('CONFIG')
$XDG_CONFIG_HOME = XDG::BaseDir.new('CONFIG', 'HOME')
$XDG_CONFIG_DIRS = XDG::BaseDir.new('CONFIG', 'DIRS')

$XDG_CACHE       = XDG::BaseDir.new('CACHE')
$XDG_CACHE_HOME  = XDG::BaseDir.new('CACHE', 'HOME')
$XDG_CACHE_DIRS  = XDG::BaseDir.new('CACHE', 'DIRS')

# Copyright (c) 2008 Rubyworks
