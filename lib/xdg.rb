require 'rbconfig'
require 'xdg/version'

# = XDG Base Directory Standard
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

  #module_function
  extend self

  # Returns user's home directory.
  #
  def home
    File.expand_path('~') # ENV['HOME']
  end

  # Access to data resource locations.
  #
  #   XDG.data.each{ |dir| ... }
  #
  def data(*glob_and_flags, &block)
    if !glob_and_flags.empty? or block_given?
      Data.select(*glob_and_flags, &block)
    else
      Data
    end
  end

  # Access to configuration locations.
  #
  #   XDG.config.each{ |dir| ... }
  #
  def config(*glob_and_flags, &block)
    if !glob_and_flags.empty? or block_given?
      Config.select(*glob_and_flags, &block)
    else
      Config
    end
  end

  # Access to cache locations.
  #
  #   XDG.cache.each{ |dir| ... }
  #
  def cache(*glob_and_flags, &block)
    if !glob_and_flags.empty? or block_given?
      Cache.select(*glob_and_flags, &block)
    else
      Cache
    end
  end

  # Each directory set shares these common methods.
  #
  module Common

    # Returns a complete list of directories, starting
    # with the home location and moving outward.
    def list
      [home, *dirs]
    end

    # Return array of matching files or directories
    # in any of the resource locations, starting with
    # the home directory and searching outward into
    # system directories.
    #
    # Unlike #select, this doesn't take a block and each
    # additional glob argument is treated as a logical-or.
    #
    #   XDG::Data.glob("stick/*.rb", "stick/*.yaml")
    #
    def glob(*glob_and_flags)
      glob, flags = *parse_arguments(*glob_and_flags)
      find = []
      list.each do |dir|
        glob.each do |pattern|
          find.concat(Dir.glob(File.join(dir, pattern), flags))
        end
      end
      find.uniq
    end

    # Return array of matching files or directories
    # in any of the resource locations, starting with
    # the home directory and searching outward into
    # system directories.
    #
    # String parameters are joined into a pathname
    # while Integers and Symbols treated as flags.
    #
    # For example, the following are equivalent:
    #
    #   XDG.data.select('stick/units', File::FNM_CASEFOLD)
    #
    #   XDG.data.select('stick', 'units', :casefold)
    #
    def select(*glob_and_flags, &block)
      glob, flag = *parse_arguments(*glob_and_flags)
      find = []
      list.each do |dir|
        path = File.join(dir, *glob)
        hits = Dir.glob(path, flag)
        hits = hits.select(&block) if block_given?
        find.concat(hits)
      end
      find.uniq
    end

    # Find a file or directory. This works just like #select
    # except that it returns the first match found.
    #
    # TODO: It would be more efficient to traverse the dirs and use #fnmatch.
    #
    def find(*glob_and_flags, &block)
      glob, flag = *parse_arguments(*glob_and_flags)
      find = nil
      list.each do |dir|
        path = File.join(dir, *glob)
        hits = Dir.glob(path, flag)
        hits = hits.select(&block) if block_given?
        find = hits.first
        break if find
      end
      find
    end

  private

    def parse_arguments(*glob_and_flags)
      glob, flags = *glob_and_flags.partition{ |e| String===e }
      glob = ['**/*'] if glob.empty?
      flag = flags.inject(0) do |m, f|
        if Symbol === f
          m + File::const_get("FNM_#{f.to_s.upcase}")
        else
          m + f.to_i
        end
      end
      return glob, flag
    end

  end

  # = DATA LOCATIONS
  #
  module Data
    include Common

    # Location of personal data directory.
    def home
      @home ||= (
        File.expand_path(
          ENV['XDG_DATA_HOME'] || File.join(XDG.home, '.local', 'share')
        )
      )
    end

    # List of shared data directores.
    def dirs
      @dirs ||= (
        dirs = ENV['XDG_DATA_DIRS'].split(/[:;]/)
        if dirs.empty?
          #dirs = [ Config::CONFIG['localdatadir'], Config::CONFIG['datadir'] ]
          dirs = Resource.dirs.map{ |d| File.join(d, 'share') }
        end
        dirs = dirs.map{ |d| File.expand_path(d) }.uniq
        dirs = dirs.select{ |d| File.directory?(d) }
        dirs
      )
    end

    extend self
  end

  # = CONFIGUTATION LOCATIONS
  #
  module Config
    include Common
    extend self

    # Location of personal config directory.
    def home
      @home ||= (
        File.expand_path(
          ENV['XDG_CONFIG_HOME'] || File.join(XDG.home, '.config')
        )
      )
    end

    # List of shared config directories.
    def dirs
      @dirs ||= (
        dirs = ENV['XDG_CONFIG_DIRS'].to_s.split(/[:;]/)
        if dirs.empty?
          #dirs = ['etc/xdg', 'etc']
          sysconfdir = ::Config::CONFIG['sysconfdir']
          dirs = [ File.join(sysconfdir, 'xdg'), sysconfdir ]
        end
        dirs = dirs.map{ |d| File.expand_path(d) }.uniq
        dirs = dirs.select{ |d| File.directory?(d) }
        dirs
      )
    end

    extend self
  end

  # = CACHE LOCATIONS
  #
  module Cache
    include Common

    # Location of user's personal cache directory.
    def home
      @home ||= (
        File.expand_path(
          ENV['XDG_CACHE_HOME'] || File.join(XDG.home, '.cache')
        )
      )
    end

    # Serves as a no-op, since there are no common cache directories
    # defined by the XDG standard. (Though one might argue that 
    # <tt>tmp/</tt> is one.)
    def dirs
      @dirs ||= []
    end

    extend self
  end

end # module XDG

# Copyright (c) 2008,2009 Thomas Sawyer
# Distributed under the terms of the Apache v2.0 license.
