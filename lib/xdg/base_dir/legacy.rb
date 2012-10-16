module XDG
  class BaseDir
    # Legacy API can serve as a stop gap until a developer
    # has time to update an program already using XDG.
    #
    # Do NOT use this module for future development!!!
    module Legacy
      #
      require 'xdg'
      require 'xdg/base_dir/extended'

      #
      extend self

      #
      def home
        File.expand_path('~')
      end

      #
      def data
        obj = XDG['DATA']
        class << obj
          def home
            XDG['DATA_HOME'].to_a.first
          end
          def dirs
            XDG['DATA_DIRS'].to_a
          end
        end
        return obj
      end

      #
      def config
        obj = XDG['CONFIG']
        class << obj
          def home
            XDG['CONFIG_HOME'].to_a.first
          end
          def dirs
            XDG['CONFIG_DIRS'].to_a
          end
          def work
            XDG['CONFIG_WORK'].to_a
          end
        end
        return obj
      end

      #
      def cache
        obj = XDG['CACHE']
        class << obj
          def home
            XDG['CACHE_HOME'].to_a.first
          end
          def dirs
            XDG['CACHE_DIRS'].to_a
          end
          def work
            XDG['CACHE_WORK'].to_a
          end
        end
        return obj
      end

    end
  end

  extend BaseDir::Legacy
end

# Copyright (c) 2008 Rubyworks
