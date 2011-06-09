module XDG

  #
  require 'xdg'
  require 'xdg/base_dir/extended'

  def self.home
    File.expand_path('~')
  end

  #
  def self.data
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
  def self.config
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
  def self.cache
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
