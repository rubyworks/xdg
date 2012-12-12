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

