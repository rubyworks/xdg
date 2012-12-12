# XDG Base Directory Standard

The 2.0 API is much a great deal more concise than the original
0.0+ and 1.0+ APIs. It consists primarily of a single
interface method `XDG[]`. Yet all the functionality of the older
API remain and then some.

First we need to require the library.

    require 'xdg'

In the applique we have setup a fake root directory with 
coorepsonding environment settings to use as test fixtures.

## Data Paths

### Home

    XDG['DATA_HOME'].environment.assert == ENV['XDG_DATA_HOME'].to_s
    XDG['DATA_HOME'].environment_variables.assert == ['XDG_DATA_HOME']

Looking at the data home location by default it should be point to
our joe user's home directory under `.local/share`.

    XDG['DATA_HOME'].to_a.assert == [$froot + 'home/joe/.local/share']

### Dirs

    XDG['DATA_DIRS'].environment.assert == ENV['XDG_DATA_DIRS'].to_s
    XDG['DATA_DIRS'].environment_variables.assert == ['XDG_DATA_DIRS']

Looking at the system data locations

    XDG['DATA_DIRS'].to_a.assert == [$froot + 'usr/share']

### Combined

    XDG['DATA'].environment_variables.assert == ['XDG_DATA_HOME', 'XDG_DATA_DIRS']

Lookking at both data location combined

    XDG['DATA'].to_a.assert == [$froot + 'home/joe/.local/share', $froot + 'usr/share']


## Config Paths

### Home

    XDG['CONFIG_HOME'].environment.assert == ENV['XDG_CONFIG_HOME'].to_s
    XDG['CONFIG_HOME'].to_a.assert == [$froot + 'home/joe/.config']

### Dirs

    XDG['CONFIG_DIRS'].environment.assert == ENV['XDG_CONFIG_DIRS'].to_s
    XDG['CONFIG_DIRS'].to_a.assert == [$froot + 'etc/xdg', $froot + 'etc']

### Combined

    XDG['CONFIG'].to_a.assert == [$froot + 'home/joe/.config', $froot + 'etc/xdg', $froot + 'etc']


## Cache Paths

### Home

    XDG['CACHE_HOME'].environment.assert == ENV['XDG_CACHE_HOME'].to_s
    XDG['CACHE_HOME'].to_a.assert == [$froot + 'home/joe/.cache']

### Dirs

    XDG['CACHE_DIRS'].environment.assert == ENV['XDG_CACHE_DIRS'].to_s
    XDG['CACHE_DIRS'].to_a.assert == [$froot + 'tmp']

### Combined

    XDG['CACHE'].to_a.assert == [$froot + 'home/joe/.cache', $froot + 'tmp']


# Extended Base Directory Standard

The extended base directory standard provides additional locations
not apart the offical standard. These are somewhat experimental.

## Resource

    XDG['RESOURCE_HOME'].environment.assert == ENV['XDG_RESOURCE_HOME'].to_s

    XDG['RESOURCE_HOME'].environment_variables.assert == ['XDG_RESOURCE_HOME']

Looking at the data home location by default it should be pointing to
our joe users home directory under `.local`.

    XDG['RESOURCE_HOME'].list.assert == ['~/.local']

    XDG['RESOURCE_HOME'].to_a.assert == [$froot + 'home/joe/.local']


## Work

The working configuration directory

    XDG['CONFIG_WORK'].environment.assert == ENV['XDG_CONFIG_WORK'].to_s

    XDG['CONFIG_WORK'].environment_variables.assert == ['XDG_CONFIG_WORK']

Looking at the config work location, by default it should be pointing to
the current working directorys `.config` or `config` directory.

    XDG['CONFIG_WORK'].list.assert == ['.config', 'config']

    XDG['CONFIG_WORK'].to_a.assert == [Dir.pwd + '/.config', Dir.pwd + '/config']

The working cache directory

    XDG['CACHE_WORK'].environment.assert == ENV['XDG_CACHE_WORK'].to_s

    XDG['CACHE_WORK'].environment_variables.assert == ['XDG_CACHE_WORK']

Looking at the cache work location, by default it should be pointing to
the current working directorys `.tmp` or `tmp` directory.

    XDG['CACHE_WORK'].list.assert == ['.tmp', 'tmp']

    XDG['CACHE_WORK'].to_a.assert == [Dir.pwd + '/.tmp', Dir.pwd + '/tmp']


# Base Directory Mixin

The base directory mixin is used to easy augment a class for 
access to a named subdirectory of the XDG directories.

    class MyAppConfig
      include XDG::BaseDir::Mixin

      def subdirectory
        'myapp'
      end
    end

    c = MyAppConfig.new

    c.config.home.to_a  #=> [$froot + 'home/joe/.config/myapp']


