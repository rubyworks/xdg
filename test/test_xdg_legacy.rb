$:.unshift 'lib'

require 'xdg/base_dir/legacy'
require 'test/unit'

# run test from fakeroot directory.
Dir.chdir(File.join(File.dirname(__FILE__), 'fakeroot'))

ENV['HOME']            = File.join(Dir.pwd, 'home')
ENV['XDG_DATA_DIRS']   = File.join(Dir.pwd, 'usr/share')
ENV['XDG_CONFIG_DIRS'] = File.join(Dir.pwd, 'etc/xdg')

class TestXDG < Test::Unit::TestCase

  # Test the standard paths.

  def test_home
    assert_equal(File.join(Dir.pwd,'home'), XDG.home)
  end

  def test_config_home
    assert_equal(File.join(Dir.pwd,'home/.config'), XDG.config.home)
  end

  def test_config_dirs
    assert_equal([File.join(Dir.pwd,"etc/xdg")], XDG.config.dirs)
  end

  def test_data_home
    assert_equal(File.join(Dir.pwd,'home/.local/share'), XDG.data.home)
  end

  def test_data_dirs
    assert_equal([File.join(Dir.pwd,'usr/share')], XDG.data.dirs)
  end

  def test_cache_home
    assert_equal(File.join(Dir.pwd,'home/.cache'), XDG.cache.home)
  end

  # Test the find methods.

  def test_data_find
    file = 'foo.dat'
    assert_equal(File.join(Dir.pwd,'home/.local/share', file), XDG.data.find(file))
    file = 'bar.dat'
    assert_equal(File.join(Dir.pwd,'usr/share', file), XDG.data.find(file))
  end

  def test_config_find
    file = 'foo.config'
    assert_equal(File.join(Dir.pwd,'home/.config', file), XDG.config.find(file))
    file = 'bar.config'
    assert_equal(File.join(Dir.pwd,'etc/xdg', file), XDG.config.find(file))
  end

  def test_cache_find
    file = 'foo.cache'
    assert_equal(File.join(Dir.pwd,'home/.cache', file), XDG.cache.find(file))
  end

  # Test the glob methods.

  def test_data_select
    file = 'foo.dat'
    assert_equal([File.join(Dir.pwd,'home/.local/share', file)], XDG.data.select(file))
    file = 'bar.dat'
    assert_equal([File.join(Dir.pwd,'usr/share', file)], XDG.data.select(file))
  end

  def test_config_select
    file = 'foo.config'
    assert_equal([File.join(Dir.pwd,'home/.config', file)], XDG.config.select(file))
    file = 'bar.config'
    assert_equal([File.join(Dir.pwd,'etc/xdg', file)], XDG.config.select(file))
  end

  def test_cache_select
    file = 'foo.cache'
    assert_equal([File.join(Dir.pwd,'home/.cache', file)], XDG.cache.select(file))
  end

  # Test the glob methods.

  def test_data_glob
    file = 'foo.dat'
    assert_equal([File.join(Dir.pwd,'home/.local/share', file)], XDG.data.glob(file))
    file = 'bar.dat'
    assert_equal([File.join(Dir.pwd,'usr/share', file)], XDG.data.glob(file))
  end

  def test_config_glob
    file = 'foo.config'
    assert_equal([File.join(Dir.pwd,'home/.config', file)], XDG.config.glob(file))
    file = 'bar.config'
    assert_equal([File.join(Dir.pwd,'etc/xdg', file)], XDG.config.glob(file))
  end

  def test_cache_glob
    file = 'foo.cache'
    assert_equal([File.join(Dir.pwd,'home/.cache', file)], XDG.cache.glob(file))
  end

  # Test the working directory variations.

  def test_config_work
    result = [File.join(Dir.pwd,'.config'), File.join(Dir.pwd,'config')]
    assert_equal(result, XDG.config.work)
  end

  def test_cache_work
    result = [File.join(Dir.pwd,'.tmp'), File.join(Dir.pwd,'tmp')]
    assert_equal(result, XDG.cache.work)
  end

end

