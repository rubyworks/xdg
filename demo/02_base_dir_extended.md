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

