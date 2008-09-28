# :Title: XDG
# :Author: &trans;
# :Copyright: (c)2008 Tiger Ops
# :License: GPLv3


# = XDG Base Directory Standard
#
# This provides a conveient library for conforming to the
# XDG Base Directory Standard.
#
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
# Some important clarifications, not made clear by the
# above specification. 
#
# The data directories are for "read-only" files. In other words once
# something is put there, it should only be read, never written to
# by a program. (Generally speaking only users or pacakge mangers should
# be adding, changing or removing files from the data locations.
#
# The config locations are where you should store files that may change,
# and effect operations depending one there content. This is like etc/
# in the FHS, but alterable by end users and and end user programs,
# not just root and sudo admin scripts.
#
# The cache location stores files that could judt as well be deleted
# and everyihtng still works find. This is for variable and temporary
# files. Like var/ in FHS.
#
# This module returns paths as strings.

module XDG

  ###############
  module_function
  ###############

  def xdg_home
    ENV['HOME'] || File.expand_path('~')
  end

  # Location of user's personal config directory.
  def xdg_config_home
    File.expand_path(
      ENV['XDG_CONFIG_HOME'] || File.join(xdg_home, '.config')
    )
  end

  # List of user's shared config directories.
  def xdg_config_dirs
    dirs = ENV['XDG_CONFIG_DIRS'].split(/[:;]/)
    if dirs.empty?
      dirs = %w{/etc/xdg}
    end
    dir.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal data directory.
  def xdg_data_home
    File.expand_path(
      ENV['XDG_DATA_HOME'] || File.join(xdg_home, '.local', 'share')
    )
  end

  # List of user's shared data directores.
  def xdg_data_dirs
    dirs = ENV['XDG_DATA_DIRS'].split(/[:;]/)
    if dirs.empty?
      dirs = %w{/usr/local/share/ /usr/share/}
    end
    dir.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal cache directory.
  def xdg_cache_home
    File.expand_path(
      ENV['XDG_CACHE_HOME'] || File.join(xdg_home, '.cache')
    )
  end

  # Find a file or directory in data dirs.
  def xdg_data_file(file)
    [data_home, *data_dirs].each do |dir|
      path = File.join(dir,file)
      break path if File.exist?(path)
    end
  end

  # Find a file or directory in config dirs.
  def xdg_config_file(file)
    [config_home, *config_dirs].each do |dir|
      path = File.join(dir,file)
      break path if File.exist?(path)
    end
  end

  # Find a file or directory in the user cache.
  def xdg_cache_file(file)
    File.join(cache_home,file)
  end

  ############################################
  # The following are not strictly XDG spec, #
  # but are useful in the same respect.      #
  ############################################

  # Location of working config directory.
  def xdg_config_work
    File.expand_path(
      #ENV['XDG_CONFIG_WORK'] || File.join(Dir.pwd, '.config')
      File.join(Dir.pwd, '.config')
    )
  end

  # Location of working data directory.
  def xdg_data_work
    File.expand_path(
      #ENV['XDG_DATA_WORK'] || File.join(Dir.pwd, '.share')
      File.join(Dir.pwd, '.share')
    )
  end

  # Location of working cache directory.
  def xdg_cache_work
    File.expand_path(
      #ENV['XDG_CACHE_WORK'] || File.join(Dir.pwd, '.cache')
      File.join(Dir.pwd, '.cache')
    )
  end

end # module XDG

