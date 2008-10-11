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

  def self.home
    ENV['HOME'] || File.expand_path('~')
  end

  # Location of user's personal config directory.
  def self.config_home
    File.expand_path(
      ENV['XDG_CONFIG_HOME'] || File.join(xdg_home, '.config')
    )
  end

  # List of user's shared config directories.
  def self.config_dirs
    dirs = ENV['XDG_CONFIG_DIRS'].to_s.split(/[:;]/)
    if dirs.empty?
      dirs = %w{/etc/xdg}
    end
    dirs.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal data directory.
  def self.data_home
    File.expand_path(
      ENV['XDG_DATA_HOME'] || File.join(xdg_home, '.local', 'share')
    )
  end

  # List of user's shared data directores.
  def self.data_dirs
    dirs = ENV['XDG_DATA_DIRS'].split(/[:;]/)
    if dirs.empty?
      dirs = %w{/usr/local/share/ /usr/share/}
    end
    dirs.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal cache directory.
  def self.cache_home
    File.expand_path(
      ENV['XDG_CACHE_HOME'] || File.join(xdg_home, '.cache')
    )
  end

  # Find a file or directory in data dirs.
  def self.data_file(file)
    find = nil
    [xdg_data_home, *xdg_data_dirs].each do |dir|
      path = File.join(dir,file)
      break find = path if File.exist?(path)
    end
    find
  end

  # Find a file or directory in config dirs.
  def self.config_file(file)
    find = nil
    [xdg_config_home, *xdg_config_dirs].each do |dir|
      path = File.join(dir,file)
      break find = path if File.exist?(path)
    end
    find
  end

  # Find a file or directory in the user cache.
  def self.cache_file(file)
    path = File.join(xdg_cache_home,file)
    File.exist?(path) ? path : nil
  end

  #--
  # The following are not strictly XDG spec,
  # but are useful in the same respect.
  #++

  # Location of working config directory.
  def self.config_work
    File.expand_path(
      #ENV['XDG_CONFIG_WORK'] || File.join(Dir.pwd, '.config')
      File.join(Dir.pwd, '.config')
    )
  end

  # Location of working data directory.
  def self.data_work
    File.expand_path(
      #ENV['XDG_DATA_WORK'] || File.join(Dir.pwd, '.share')
      File.join(Dir.pwd, '.share')
    )
  end

  # Location of working cache directory.
  def self.cache_work
    File.expand_path(
      #ENV['XDG_CACHE_WORK'] || File.join(Dir.pwd, '.cache')
      File.join(Dir.pwd, '.cache')
    )
  end

  ###############
  module_function
  ###############

  def xdg_home        ; XDG.home        ; end
  def xdg_config_home ; XDG.config_home ; end
  def xdg_config_dirs ; XDG.config_dirs ; end
  def xdg_data_home   ; XDG.data_home   ; end
  def xdg_data_dirs   ; XDG.data_dirs   ; end
  def xdg_cache_home  ; XDG.cache_home  ; end

  def xdg_data_file(file)   ; XDG.data_file(file)   ; end
  def xdg_config_file(file) ; XDG.config_file(file) ; end
  def xdg_cache_file(file)  ; XDG.cache_file(file)  ; end

  def xdg_config_work ; XDG.config_work ; end
  def xdg_data_work   ; XDG.data_work   ; end
  def xdg_cache_work  ; XDG.cache_work  ; end

end # module XDG

