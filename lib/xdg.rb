require 'rbconfig'

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

  extend self    #module_function

  # Returns user's home directory.
  def home
    File.expand_path('~') # ENV['HOME']
  end

  # U S E R  L O C A T I O N S

  # Location of local directory.
  def resource_home
    File.expand_path(
      ENV['XDG_RESOURCE_HOME'] || File.join(home, '.local')
    )
  end

  # List of local directores.
  def resource_dirs
    dirs = ENV['XDG_RESOURCE_DIRS'].split(/[:;]/)
    if dirs.empty?
      dirs = ['/usr/local', '/usr'].select{ |f| File.directory?(f) }
    end
    dirs = dirs.map{ |d| File.expand_path(d) }.uniq
    #dirs = dirs.select{ |d| File.directory?(d) }
    dirs
  end

  # Find a file or directory in data dirs.
  #
  # See: +local_select+.
  #
  def resource_find(*glob_and_flags, &block)
    data_select(*glob_and_flags, &block).first
  end

  # Return array of matching files or directories
  # in any of the resource locations.
  #
  # This starts with the user's home directory
  # and then searches system directories.
  #
  # String parameters are joined into a pathname
  # while Integers and Symbols treated as flags.
  #
  # For example, the following are equivalent:
  #
  #   XDG.local_select('stick/units', File::FNM_CASEFOLD)
  #
  #   XDG.local_select('stick', 'uits', :casefold)
  #
  def resource_select(*glob_and_flags, &block)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
    glob = ['**/*'] if glob.empty?
    flag = flags.inject(0) do |m, f|
      if Symbol === f
        m + File::const_get("FNM_#{f.to_s.upcase}")
      else
        m + f.to_i
      end
    end
    find = []
    [local_home, *local_dirs].each do |dir|
      path = File.join(dir, *glob)
      if block_given?
        find.concat(Dir.glob(path, flag).select(&block))
      else
        find.concat(Dir.glob(path, flag))
      end
    end
    find
  end

  # C O N F I G  L O C A T I O N S

  # Location of personal config directory.
  def config_home
    File.expand_path(
      ENV['XDG_CONFIG_HOME'] || File.join(home, '.config')
    )
  end

  # List of shared config directories.
  def config_dirs
    dirs = ENV['XDG_CONFIG_DIRS'].to_s.split(/[:;]/)
    if dirs.empty?
      #dirs = ['etc/xdg', 'etc']
      sysconfdir = File.join(Config::CONFIG['sysconfdir']
      dirs = [File.join(sysconfdir, 'xdg'), sysconfdir]
    end
    dirs = dirs.map{ |d| File.expand_path(d) }.uniq
    #dirs = dirs.select{ |d| File.directory?(d) }
    dirs
  end

  # Return the fist matching file or directory
  # from the config locations.
  #
  # See: +config_select+.
  #
  def config_find(*glob_and_flags, &block)
    config_select(*glob_and_flags, &block).first
  end

  # Return array of matching files or directories
  # in any of the config locations.
  #
  # This starts with the user's home directory
  # and then searches system directories.
  #
  # String parameters are joined into a pathname
  # while Integers and Symbols treated as flags.
  #
  # For example, the following are equivalent:
  #
  #   XDG.config_select('sow/plugins', File::FNM_CASEFOLD)
  #
  #   XDG.config_select('sow', 'plugins', :casefold)
  #
  def config_select(*glob_and_flags)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
    glob = ['**/*'] if glob.empty?
    flag = flags.inject(0) do |m, f|
      if Symbol === f
        m + File::const_get("FNM_#{f.to_s.upcase}")
      else
        m + f.to_i
      end
    end
    find = []
    [config_home, *config_dirs].each do |dir|
      path = File.join(dir, *glob)
      if block_given?
        find.concat(Dir.glob(path, flag).select(&block))
      else
        find.concat(Dir.glob(path, flag))
      end
    end
    find
  end

  # D A T A  L O C A T I O N S

  # Location of personal data directory.
  def data_home
    File.expand_path(
      ENV['XDG_DATA_HOME'] || File.join(home, '.local', 'share')
    )
  end

  # List of shared data directores.
  def data_dirs
    dirs = ENV['XDG_DATA_DIRS'].split(/[:;]/)
    if dirs.empty?
      #dirs = [ Config::CONFIG['localdatadir'], Config::CONFIG['datadir'] ]
      dirs = local_dirs.map{ |d| File.join(d, 'share')
    end
    dirs = dirs.map{ |d| File.expand_path(d) }.uniq
    #dirs = dirs.select{ |d| File.directory?(d) }
    dirs
  end

  # Find a file or directory in data dirs.
  #
  # See: +data_select+.
  #
  def data_find(*glob_and_flags, &block)
    data_select(*glob_and_flags, &block).first
  end

  # Return array of matching files or directories
  # in any of the data locations.
  #
  # This starts with the user's home directory
  # and then searches system directories.
  #
  # String parameters are joined into a pathname
  # while Integers and Symbols treated as flags.
  #
  # For example, the following are equivalent:
  #
  #   XDG.data_select('stick/units', File::FNM_CASEFOLD)
  #
  #   XDG.data_select('stick', 'uits', :casefold)
  #
  def data_select(*glob_and_flags, &block)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
    glob = ['**/*'] if glob.empty?
    flag = flags.inject(0) do |m, f|
      if Symbol === f
        m + File::const_get("FNM_#{f.to_s.upcase}")
      else
        m + f.to_i
      end
    end
    find = []
    [data_home, *data_dirs].each do |dir|
      path = File.join(dir, *glob)
      if block_given?
        find.concat(Dir.glob(path, flag).select(&block))
      else
        find.concat(Dir.glob(path, flag))
      end
    end
    find
  end

  # C A C H E  L O C A T I O N S

  # Location of user's personal cache directory.
  def cache_home
    File.expand_path(
      ENV['XDG_CACHE_HOME'] || File.join(home, '.cache')
    )
  end

  # Return the fist matching file or directory
  # in the cache directory.
  #
  # See: +cache_select+.
  #
  def cache_find(*glob_and_flags, &block)
    cache_select(*glob_and_flags, &block).first
  end

  # Return array of matching files or directories
  # from the cache directory.
  #
  # String parameters are joined into a pathname
  # while Integers and Symbols treated as flags.
  #
  # For example, the following are equivalent:
  #
  #   XDG.cache_select('sow/tmp', File::FNM_CASEFOLD)
  #
  #   XDG.cache_select('sow', 'tmp', :casefold)
  #
  def cache_select(*glob_and_flags)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
    glob = ['**/*'] if glob.empty?
    flag = flags.inject(0) do |m, f|
      if Symbol === f
        m + File::const_get("FNM_#{f.to_s.upcase}")
      else
        m + f.to_i
      end
    end
    path = File.join(cache_home,*glob)
    if block_given?
      Dir.glob(path, flag).select(&block)
    else
      Dir.glob(path, flag)
    end
  end

  # W O R K
  #
  # The following are not strictly XDG spec, but they
  # can be useful in an analogous respect.

  # Location of working config directory.
  def config_work
    File.expand_path(
      File.join(Dir.pwd, '.config')
    )
  end

  # Location of working cache directory.
  def cache_work
    File.expand_path(
      File.join(Dir.pwd, '.cache')
    )
  end

  # DEPRECATED -- Does not make sense to have this.
  # Location of working data directory.
  #def data_work
  #  File.expand_path(
  #    File.join(Dir.pwd, '.local')
  #  )
  #end

end # module XDG

# Copyright (c) 2008,2009 Thomas Sawyer
# Distributed under the terms of the LGPL v3.
