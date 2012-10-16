# XDG Base Directory Standard
#
# This provides a conveient library for conforming to the
# XDG Base Directory Standard.
#
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
# Some important clarifications, not made clear by the above specification. 
#
# The data directories are for "read-only" files. In other words once
# something is put there, it should only be read, and never written to
# by a program. (Generally speaking only users or package managers should
# be adding, changing or removing files from the data locations.)
#
# The config locations are where you store files that may change,
# and effect your applications depending on their content. This is like
# etc/ in the FHS, but alterable by end users and end user programs,
# not just root and sudo admin scripts.
#
# The cache locations stores files that could just as well be deleted
# and everything would still work fine. This is for variable and
# temporary files. Much like var/ and tmp/ in FHS.
#
# The module returns all paths as String.
#
module XDG
  if RUBY_VERSION > '1.9'
    require_relative 'xdg/version'
    require_relative 'xdg/base_dir'
    require_relative 'xdg/base_dir/extended'
    require_relative 'xdg/base_dir/mixin'
  else
    require 'xdg/version'
    require 'xdg/base_dir'
    require 'xdg/base_dir/extended'
    require 'xdg/base_dir/mixin'
  end

  #
  def self.[](*env_path)
    BaseDir.new(*env_path)
  end
end

# Copyright (c) 2008 Rubyworks
