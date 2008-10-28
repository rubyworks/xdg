require 'test/unit'
$: << 'lib'
require 'xdg'

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
    assert_equal(File.join(Dir.pwd,'home/.config'), XDG.config_home)
  end

  def test_config_dirs
    assert_equal([File.join(Dir.pwd,"etc/xdg")], XDG.config_dirs)
  end

  def test_data_home
    assert_equal(File.join(Dir.pwd,'home/.local/share'), XDG.data_home)
  end

  def test_data_dirs
    assert_equal([File.join(Dir.pwd,'usr/share')], XDG.data_dirs)
  end

  def test_cache_home
    assert_equal(File.join(Dir.pwd,'home/.cache'), XDG.cache_home)
  end

  # Test the find methods.

  def test_data_find
    file = 'foo.dat'
    assert_equal(File.join(Dir.pwd,'home/.local/share', file), XDG.data_find(file))
    file = 'bar.dat'
    assert_equal(File.join(Dir.pwd,'usr/share', file), XDG.data_find(file))
  end

  def test_config_find
    file = 'foo.config'
    assert_equal(File.join(Dir.pwd,'home/.config', file), XDG.config_find(file))
    file = 'bar.config'
    assert_equal(File.join(Dir.pwd,'etc/xdg', file), XDG.config_find(file))
  end

  def test_cache_find
    file = 'foo.cache'
    assert_equal(File.join(Dir.pwd,'home/.cache', file), XDG.cache_find(file))
  end

  # Test the glob methods.

  def test_data_select
    file = 'foo.dat'
    assert_equal([File.join(Dir.pwd,'home/.local/share', file)], XDG.data_select(file))
    file = 'bar.dat'
    assert_equal([File.join(Dir.pwd,'usr/share', file)], XDG.data_select(file))
  end

  def test_config_select
    file = 'foo.config'
    assert_equal([File.join(Dir.pwd,'home/.config', file)], XDG.config_select(file))
    file = 'bar.config'
    assert_equal([File.join(Dir.pwd,'etc/xdg', file)], XDG.config_select(file))
  end

  def test_cache_select
    file = 'foo.cache'
    assert_equal([File.join(Dir.pwd,'home/.cache', file)], XDG.cache_select(file))
  end

  # Test the working directory variations.

  def test_config_work
    assert_equal(File.join(Dir.pwd,'.config'), XDG.config_work)
  end

  def test_data_work
    assert_equal(File.join(Dir.pwd,'.share'), XDG.data_work)
  end

  def test_cache_work
    assert_equal(File.join(Dir.pwd,'.cache'), XDG.cache_work)
  end

end

