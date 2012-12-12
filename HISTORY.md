# RELEASE HISTORY

## 2.2.3 / 2012-12-13

This release switches to RbConfig instead of Config, which Ruby
is deprecating.

Changes:

* Switch Config to RbConfig.


## 2.2.2 / 2011-10-30

Just a maintenance release to bring the build configuration
up to date. Also, change license to BSD-2-Clause.

Changes:

* Modernize build configuration
* Switch to BSD-2-Clause license.


## 2.2.1 / 2011-06-11

This release changes BaseDir#to_s to return the first directory
entry, and moves the old #to_s to #environment_with_defaults
with an alias of #env. The old #env now being called #environment.

Changes:

* Rename #env to #environment.
* Rename #to_s to #environment_with_defaults.
* Modify #to_s to return first directory.


## 2.1.0 / 2011-06-09

This release changes the BaseDir#list method, where as it used
to be an alias for #to_a, it now differs in that it does not
expand the paths. In addtion a few tests were fixed and version
number properly updated int hte version.rb file.

Changes:

* Change BaseDir#list to not expand paths.
* Properly assign VERSION constant.
* Fix broken qed tests.


## 2.0.0 / 2011-06-09

Major new release is full rewrite of the API, with an eye out for
support future XDG standards beyond the base directories. The
new API uses a single point of entry `XDG[]` (a shortcut for
`XDG::BaseDir[]`).

Changes:

* Complete rewrite of API.
* Utilize single point of entry interface.
* Structure project for future support of more of XDG.


## 1.0.0 / 2009-12-01

This is major reimplementation of the XDG API to be more flexiable
and object-oriented. Instead of a single module with every 
needed method, the system is devided up into sub-modules, one for
each set of XDG locations. So, for example, instead of "XDG.data_dirs"
you use "XDG::Data.dirs" or "XDG.data.dirs".

Changes:

* Reworked API and underlying implementation to be more OOP-style.
* Began work on xdg/extended.rb, exploring future proposals.
* Provides xdg/compat.rb, for backward compatabilty (temporary).


## 0.5.2 / 2009-05-30

This release requires rbconfig.rb and uses system entries in place of
some hardcoded FHS locations.

Changes:

* Replaced hardcoded system directories with rbconfig entries.


## 0.5.1 / 2008-11-17

Changes:

* Fixed data work directory is '.local', not '.share'
* Deprecated #data_work


## 0.5.0 / 2008-10-28

Changes:

* Changed _glob to _select


## 0.4.0 / 2008-10-26

This release removes the xdg_ prefix from the instance-level
method names. Now module and instance levels are the same.

Also, data_file, config_file and cache_file have been replaced with
data_find, config_find, cache_find, data_glob, config_glob and
cache_glob.

What's next? Well, I can't say I'm fond of the term 'glob', so I
may rename that to 'map' or 'collect' (or 'select'?)  and then 
add the ability to use blocks for matching too.

Changes:

* Renamed instance level methods without 'xdg_' prefix.
* Replace _file methods with _find and _glob methods.
* Prepare for v0.4 release
* Remove some old commented-out code
* Fixed data_find and data_glob
* Update RELEASE file
* Updated documentation for 0.4 release
* Added MANIFEST to .gitignore
* Correction or RELEASE
* Fixed plural in RELEASE file


## 0.3.0 / 2008-10-11

Changes:

* Removed xdg_ prefix from module methods
* Moved web/index.html to doc directory
* Updated reap serives
* Prepare for next release
* Fixed issue of xdg_ prefix still being used internally


## 0.1.0 / 2008-09-27

Changes:

* Started project

