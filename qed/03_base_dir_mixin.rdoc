= Base Directory Mixin

    require 'xdg/base_dir/mixin'

The base directory mixin is used to easy augment a class for 
access to a named subdirectory of the XDG directories.

    class MyAppConfig
      include XDG::BaseDir::Mixin

      def subdirectory
        'myapp'
      end
    end

    c = MyAppConfig.new

    c.config.home.to_s  #=> '~/.config/myapp'

