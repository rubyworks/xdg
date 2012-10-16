module XDG

  # Base directory interface class.
  class BaseDir

    #
    DEFAULTS['XDG_RESOURCE_HOME'] = ['~/.local']
    DEFAULTS['XDG_RESOURCE_DIRS'] = ['/usr/local','/usr']

    # Working directory
    # TODO: Not sure about these defaults
    DEFAULTS['XDG_CONFIG_WORK']   = ['.config','config']
    DEFAULTS['XDG_CACHE_WORK']    = ['.tmp','tmp']
    DEFAULTS['XDG_RESOURCE_WORK'] = ['.local']
  end

end

# Copyright (c) 2008 Rubyworks
