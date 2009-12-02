require 'xdg'

module XDG

  # Access to resource locations.
  #
  #   XDG.resource.each{ |dir| ... }
  #
  def resource(*glob_and_flags, &block)
    if !glob_and_flags.empty? or block_given?
      Resource.select(*glob_and_flags, &block)
    else
      Resource
    end
  end

  # = USER RESOURCES
  #
  module Resource
    include Common

    # Location of personal resource directory.
    def home
      @home ||= (
        File.expand_path(
          ENV['XDG_RESOURCE_HOME'] || File.join(XDG.home, '.local')
        )
      )
    end

    # List of common user directores.
    def dirs
      @dirs ||= (
        dirs = ENV['XDG_RESOURCE_DIRS'].split(/[:;]/)
        if dirs.empty?
          dirs = ['/usr/local', '/usr']
        end
        dirs = dirs.map{ |d| File.expand_path(d) }.uniq
        dirs = dirs.select{ |d| File.directory?(d) }
        dirs
      )
    end

    extend self
  end

  module Config

    # Location of working config directory.
    #
    # This is not not strictly XDG spec, but it
    # can be useful in an analogous respect.
    #
    def work
      @work ||= (
        File.expand_path(
          File.join(Dir.pwd, '.config')
        )
      )
    end

  end

  module Cache

    # Location of working cache directory.
    #
    # This is not strictly XDG spec, but it
    # can be useful in an analogous respect.
    #
    def work
      @work ||= (
        File.expand_path(
          File.join(Dir.pwd, '.cache')
        )
      )
    end

  end

end

# Copyright (c) 2008,2009 Thomas Sawyer
# Distributed under the terms of the LGPL v3.
