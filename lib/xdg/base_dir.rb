module XDG

  # Base Directory Standard
  class BaseDir

    # Try to get information from Ruby's install configuration.
    require 'rbconfig'

    sysconfdir = ::RbConfig::CONFIG['sysconfdir'] || '/etc'
    datadir    = ::RbConfig::CONFIG['datadir']    || '/usr/share'

    # Standard defaults for locations.
    DEFAULTS = {
      'XDG_DATA_HOME'   => ['~/.local/share'],
      'XDG_DATA_DIRS'   => ['/usr/local/share', datadir],
      'XDG_CONFIG_HOME' => ['~/.config'],
      'XDG_CONFIG_DIRS' => [File.join(sysconfdir,'xdg'), sysconfdir],
      'XDG_CACHE_HOME'  => ['~/.cache'],
      'XDG_CACHE_DIRS'  => ['/tmp']
    }

    # BaseDir iterates over directory paths.
    include Enumerable

    # Shortcut for `BaseDir.new`.
    def self.[](*env)
      new(*env)
    end

    # Initialize new instance of BaseDir class.
    def initialize(*env)
      @environment_variables = []
      env.each do |v|
        v = v.to_s.upcase
        if v !~ /_/
          @environment_variables << 'XDG_' + v + '_HOME'
          @environment_variables << 'XDG_' + v + '_DIRS'
        else
          @environment_variables << 'XDG_' + v
        end
      end
    end

    # The environment variables being referenced.
    #
    # @return [Array] list of XDG environment variable names
    def environment_variables
      @environment_variables
    end

    # The environment setting, or it's equivalent when the BaseDir
    # is a combination of environment variables.
    #
    # @return [String] evnironment vsetting
    def environment
      environment_variables.map{ |v| ENV[v] }.join(':')
    end

    # This is same as #environment, but also includes default values.
    #
    # @return [String] envinronment value.
    def environment_with_defaults
      environment_variables.map{ |v| ENV[v] || DEFAULTS[v] }.join(':')
    end

    # Shortcut for #environment_with_defaults.
    alias_method :env, :environment_with_defaults

    # Returns a complete list of expanded directories.
    #
    # @return [Array<String>] expanded directory list
    def to_a
      environment_variables.map do |v|
        if paths = ENV[v]
          dirs = paths.split(/[:;]/)
        else
          dirs = DEFAULTS[v]
        end
        dirs.map{ |path| expand(path) }
      end.flatten
    end

    # BaseDir is essentially an array.
    alias_method :to_ary, :to_a

    # Number of directory paths.
    def size
      to_a.size
    end

    # Iterate of each directory.
    def each(&block)
      to_a.each(&block)
    end

    # Returns an *unexpanded* list of directories.
    #
    # @return [Array<String>] unexpanded directory list
    def list
      environment_variables.map do |v|
        if paths = ENV[v]
          dirs = paths.split(/[:;]/)
        else
          dirs = DEFAULTS[v]
        end
        if subdirectory
          dirs.map{ |path| File.join(path, subdirectory) }
        else
          dirs
        end
      end.flatten
    end

    # List of directories as Pathanme objects.
    #
    # @return [Array<Pathname>] list of directories as Pathname objects
    def paths
      map{ |dir| Pathname.new(dir) }
    end

    # Returns the first directory expanded. Since a environment settings
    # like `*_HOME` will only have one directory entry, this definition
    # of #to_s makes utilizing those more convenient.
    #
    # @return [String] directory
    def to_s
      to_a.first
    end

    # The first directory converted to a Pathname object.
    #
    # @return [Pathname] pathname of first directory
    def to_path
      Pathname.new(to_a.first)
    end

    # The common subdirectory.
    attr :subdirectory

    # Set subdirectory to be applied to all paths.
    def subdirectory=(path)
      @subdirectory = path.to_s
    end

    # Set subdirectory to be applied to all paths and return `self`.
    #
    # @return [BaseDir] self
    def with_subdirectory(path)
      @subdirectory = path if path
      self
    end

    # Return array of matching files or directories
    # in any of the resource locations, starting with
    # the home directory and searching outward into
    # system directories.
    #
    # Unlike #select, this doesn't take a block and each
    # additional glob argument is treated as a logical-or.
    #
    #   XDG[:DATA].glob("stick/*.rb", "stick/*.yaml")
    #
    def glob(*glob_and_flags)
      glob, flags = *parse_arguments(*glob_and_flags)
      find = []
      to_a.each do |dir|
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
    #   XDG::BaseDir[:DATA,:HOME].select('stick/units', File::FNM_CASEFOLD)
    #
    #   XDG::BaseDir[:DATA,:HOME].select('stick', 'units', :casefold)
    #
    def select(*glob_and_flags, &block)
      glob, flag = *parse_arguments(*glob_and_flags)
      find = []
      to_a.each do |dir|
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
    def find(*glob_and_flags, &block)
      glob, flag = *parse_arguments(*glob_and_flags)
      find = nil
      to_a.each do |dir|
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

    #
    def expand(path)
      if subdirectory
        File.expand_path(File.join(path, subdirectory))
      else
        File.expand_path(path)
      end
    end

    # If Pathname is referenced the library is automatically loaded.
    def self.const_missing(const)
      if const == :Pathname
        require 'pathname'
        ::Pathname
      else
        super(const)
      end
    end

  end

end

# Copyright (c) 2008 Rubyworks
