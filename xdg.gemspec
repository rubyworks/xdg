--- !ruby/object:Gem::Specification 
name: xdg
version: !ruby/object:Gem::Version 
  prerelease: 
  version: 2.0.0
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-06-09 00:00:00 Z
dependencies: []

description: XDG provides a module for supporting the XDG Base Directory Standard. See http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html
email: transfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- .ruby
- lib/xdg/base_dir/extended.rb
- lib/xdg/base_dir/global_variables.rb
- lib/xdg/base_dir/legacy.rb
- lib/xdg/base_dir/mixin.rb
- lib/xdg/base_dir.rb
- lib/xdg/version.rb
- lib/xdg.rb
- qed/01_base_dir.rdoc
- qed/02_base_dir_extended.rb
- qed/03_base_dir_mixin.rb
- qed/applique/fakeroot.rb
- qed/fixtures/fakeroot/etc/xdg/bar.config
- qed/fixtures/fakeroot/home/.cache/foo.cache
- qed/fixtures/fakeroot/home/.config/foo.config
- qed/fixtures/fakeroot/home/.local/share/foo.dat
- qed/fixtures/fakeroot/home/joe/foo.txt
- qed/fixtures/fakeroot/usr/share/bar.dat
- test/fakeroot/etc/xdg/bar.config
- test/fakeroot/home/.cache/foo.cache
- test/fakeroot/home/.config/foo.config
- test/fakeroot/home/.local/share/foo.dat
- test/fakeroot/usr/share/bar.dat
- test/test_xdg_legacy.rb
- HISTORY.rdoc
- APACHE2.txt
- README.rdoc
homepage: http://rubyworks.github.com/xdg
licenses: 
- Apache 2.0
post_install_message: 
rdoc_options: 
- --title
- XDG API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
requirements: []

rubyforge_project: xdg
rubygems_version: 1.8.2
signing_key: 
specification_version: 3
summary: XDG provides an interface for using XDG directory standard.
test_files: []

