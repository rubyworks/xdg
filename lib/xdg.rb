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

  extend self    #module_function

  def home
    ENV['HOME'] || File.expand_path('~')
  end

  # Location of user's personal config directory.
  def config_home
    File.expand_path(
      ENV['XDG_CONFIG_HOME'] || File.join(home, '.config')
    )
  end

  # List of user's shared config directories.
  def config_dirs
    dirs = ENV['XDG_CONFIG_DIRS'].to_s.split(/[:;]/)
    if dirs.empty?
      dirs = %w{/etc/xdg}
    end
    dirs.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal data directory.
  def data_home
    File.expand_path(
      ENV['XDG_DATA_HOME'] || File.join(home, '.local', 'share')
    )
  end

  # List of user's shared data directores.
  def data_dirs
    dirs = ENV['XDG_DATA_DIRS'].split(/[:;]/)
    if dirs.empty?
      dirs = %w{/usr/local/share/ /usr/share/}
    end
    dirs.collect{ |d| File.expand_path(d) }
  end

  # Location of user's personal cache directory.
  def cache_home
    File.expand_path(
      ENV['XDG_CACHE_HOME'] || File.join(home, '.cache')
    )
  end

  # Find a file or directory in data dirs.
  def data_file(file)
    find = nil
    [data_home, *data_dirs].each do |dir|
      path = File.join(dir,file)
      break find = path if File.exist?(path)
    end
    find
  end

  # Return the fist matching file or directory
  # from the config locations.
  #
  # See +config_glog+.
  def config_find(*glob_and_flags)
    config_glob(*glob_and_flags).first
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
  #   XDG.config_glob('sow/plugins', File::FNM_CASEFOLD)
  #
  #   XDG.config_glob('sow', 'plugins', :casefold)
  #
  def config_glob(*glob_and_flags)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
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
      find.concat(Dir.glob(path, flag))
    end
    find
  end

  # Return the fist matching file or directory
  # in the cache directory.
  #
  # See +cache_glog+.
  def cache_find(*glob_and_flags)
    cache_glob(*glob_and_flags).first
  end

  # Return array of matching files or directories
  # from the cache directory.
  #
  # String parameters are joined into a pathname
  # while Integers and Symbols treated as flags.
  #
  # For example, the following are equivalent:
  #
  #   XDG.cache_glob('sow/tmp', File::FNM_CASEFOLD)
  #
  #   XDG.cache_glob('sow', 'tmp', :casefold)
  #
  def cache_glob(*glob_and_flags)
    glob, flags = *glob_and_flags.partition{ |e| String===e }
    flag = flags.inject(0) do |m, f|
      if Symbol === f
        m + File::const_get("FNM_#{f.to_s.upcase}")
      else
        m + f.to_i
      end
    end
    path = File.join(cache_home,*glob)
    Dir.glob(path, flag)
  end

  #--
  # The following are not strictly XDG spec,
  # but are useful in a similar respect.
  #++

  # Location of working config directory.
  def config_work
    File.expand_path(
      File.join(Dir.pwd, '.config')
    )
  end

  # Location of working data directory.
  def data_work
    File.expand_path(
      File.join(Dir.pwd, '.share')
    )
  end

  # Location of working cache directory.
  def cache_work
    File.expand_path(
      File.join(Dir.pwd, '.cache')
    )
  end

end # module XDG

