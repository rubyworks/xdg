# XDG Standards for Ruby

[Homepage](http://rubyworks.github.com/xdg) |
[Source Code](http://github.com/rubyworks/xdg) |
[Report Issue](http://github.com/rubyworks/xdg/issues) |
[Mailing List](http://googlegroups.com/group.rubyworks-mailinglist) |
[Chat Room](irc://irc.freenode.net/rubyworks)

[![Build Status](https://secure.travis-ci.org/rubyworks/xdg.png)](http://travis-ci.org/rubyworks/xdg)


## Introduction

XDG provides an easy to use Ruby library for working with XDG standards.

Presently, it only supports the XDG Base Directory Standard.

If your program utilizes user or system-wide support files
(e.g. configuration files), you owe it to yourself to checkout
the XDG base directory standard.

You can learn more about the standard at:
http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html


## How to Use

For working with XDG base directories, XDG provides a very simple
yet flexible interface, `XDG[]`. Let's say you want to work
with the $XDG_CONFIG_HOME directory. Simply use:

    XDG['CONFIG_HOME']

This will give you access to a number of useful methods all tied
into the user's personal configuration directory. Some examples:

    XDG['CONFIG_HOME'].glob(pattern)
    XDG['CONFIG_HOME'].select(pattern){ |path| ... }
    XDG['CONFIG_HOME'].find(pattern){ |path| ... }

The same holds true for the other base directories.

    XDG['DATA_HOME']
    XDG['DATA_DIRS']

    XDG['CACHE_HOME']
    XDG['CACHE_DIRS']

By leaving out the last qualifier, XDG will provide an interface
that ties into both the `HOME` and `DIRS` paths.

    XDG['DATA']
    XDG['CONFIG']
    XDG['CACHE']

If you know XDG these are pretty much self-explanatory.
But see the YARD-based API documentation for further specifics.

### Extended Functionality

The Ruby XDG module also provides extended functionality
not part of the standard specification. These extensions are
simply add-on functionality deemed useful, or implementations
of  proposals being discussed for a possible future version of
the standard.

    XDG['CONFIG_WORK']
    XDG['CACHE_WORK']

See the API documentation to learn more. Note that the extended modules
are subject to greater potential for change as they are still being refined.

### Base Directory Mixin

XDG provides a convenient base directory mixin that can provide handy a
interface to a classes.

    class MyAppConfig
      include XDG::BaseDir::Mixin

      def subdirectory
        'myapp'
      end
    end

    c = MyAppConfig.new

    c.config.home.to_s  #=> '~/.config/myapp'


### Legacy API

Version 2.0+ of library marks a major departure from the earlier
"fluid" notation of previous releases. Where as one used to do:

    XDG.data.home

With the new API one now does:

    XDG['DATA_HOME']

This was done for a few reasons, but primarily because it reflects more
closely Ruby's interface to the environment variables themselves, e.g.

    ENV['XDG_DATA_HOME']

If you prefer the older style, a compatibility layer is provided. You will
need to load:

    require 'xdg/base_dir/legacy'

However we STRONGLY RECOMMEND that you do not use the legacy API --use it only
if you need to keep some old code working and don't have time to update it at
the moment. Sometime in the future the legacy API will be deprecated.


## How to Install

Using RubyGems:

    $ sudo gem install xdg

Installing the tarball requires Ruby Setup (see http://rubyworks.github.com/setup).

    $ tar -xvzf xdg-0.5.2
    $ cd xdg-0.5.2
    $ sudo setup.rb all


## Development

[GitHub](http://github.com) hosts our [source code](http://github.com/rubyworks/xdg)
and [issue ticket system](http://github.com/rubyworks/xdg/issues).

To contribute to the project please fork the repository, ideally, create a new
topic branch for your work, and submit a pull request.


## Copyright & License

Copyright (c) 2008 Rubyworks

Distributed under the terms of the *FreeBSD* license.

See LICENSE.txt file for details.

