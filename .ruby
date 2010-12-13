--- 
name: xdg
company: RubyWorks
title: XDG
contact: Thomas Sawyer <transfire@gmail.com>
resources: 
  code: http://github.com/rubyworks/xdg
  home: http://rubyworks.github.com/xdg
pom_verison: 1.0.0
manifest: 
- .ruby/date
- .ruby/loadpath
- .ruby/name
- .ruby/version
- lib/xdg/compat.rb
- lib/xdg/extended.rb
- lib/xdg.rb
- script/test
- test/fakeroot/etc/xdg/bar.config
- test/fakeroot/home/.cache/foo.cache
- test/fakeroot/home/.config/foo.config
- test/fakeroot/home/.local/share/foo.dat
- test/fakeroot/usr/share/bar.dat
- test/test_xdg.rb
- README.rdoc
- HISTORY
- VERSION
- COPYING
version: 1.0.0
copyright: Copyright (c) 2008 Thomas Sawyer
licenses: 
- Apache 2.0
description: 
  XDG provides a module for supporting the XDG Base Directory Standard. See: http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html
summary: XDG provides an interface for using XDG directory standard.
authors: 
- Thomas Sawyer
created: 2008-09-27
