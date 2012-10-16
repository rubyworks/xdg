module XDG
  class BaseDir
    #
    # The BaseDir::Mixin module can be used to add XDG base directory
    # methods to your own classes.
    #
    #     class MyAppConfig
    #       include XDG::BaseDir::Mixin
    #
    #       def subdirectory
    #         'myapp'
    #       end
    #     end
    #
    #     c = MyAppConfig.new
    #
    #     c.config.home.list  #=> ['~/.config/myapp']
    #
    module Mixin

      # @todo do we need this?
      extend self

      # Override this method to change the subdirectory of the mixin.
      def subdirectory
        nil
      end

      #
      def home
        File.expand_path('~')
      end

      #
      def data
        obj = XDG['DATA'].with_subdirectory(subdirectory)
        class << obj
          def home
            XDG['DATA_HOME'].with_subdirectory(subdirectory)
          end
          def dirs
            XDG['DATA_DIRS'].with_subdirectory(subdirectory)
          end
        end
        return obj
      end

      #
      def config
        obj = XDG['CONFIG'].with_subdirectory(subdirectory)
        class << obj
          def home
            XDG['CONFIG_HOME'].with_subdirectory(subdirectory)
          end
          def dirs
            XDG['CONFIG_DIRS'].with_subdirectory(subdirectory)
          end
          def work
            XDG['CONFIG_WORK'].with_subdirectory(subdirectory)
          end
        end
        return obj
      end

      #
      def cache
        obj = XDG['CACHE'].with_subdirectory(subdirectory)
        class << obj
          def home
            XDG['CACHE_HOME'].with_subdirectory(subdirectory)
          end
          def dirs
            XDG['CACHE_DIRS'].with_subdirectory(subdirectory)
          end
          def work
            XDG['CACHE_WORK'].with_subdirectory(subdirectory)
          end
        end
        return obj
      end

    end
  end
end

# Copyright (c) 2008 Rubyworks
