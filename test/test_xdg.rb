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

  def test_xdg_home
    assert_equal(File.join(Dir.pwd,'home'), XDG.xdg_home)
  end

  def test_xdg_config_home
    assert_equal(File.join(Dir.pwd,'home/.config'), XDG.xdg_config_home)
  end

  def test_xdg_config_dirs
    assert_equal([File.join(Dir.pwd,"etc/xdg")], XDG.xdg_config_dirs)
  end

  def test_xdg_data_home
    assert_equal(File.join(Dir.pwd,'home/.local/share'), XDG.xdg_data_home)
  end

  def test_xdg_data_dirs
    assert_equal([File.join(Dir.pwd,'usr/share')], XDG.xdg_data_dirs)
  end

  def test_xdg_cache_home
    assert_equal(File.join(Dir.pwd,'home/.cache'), XDG.xdg_cache_home)
  end

  # Test the file lookups.

  def test_xdg_data_file
    file = 'foo.dat'
    assert_equal(File.join(Dir.pwd,'home/.local/share', file), XDG.xdg_data_file(file))
    file = 'bar.dat'
    assert_equal(File.join(Dir.pwd,'usr/share', file), XDG.xdg_data_file(file))
  end

  def test_xdg_config_file
    file = 'foo.config'
    assert_equal(File.join(Dir.pwd,'home/.config', file), XDG.xdg_config_file(file))
    file = 'bar.config'
    assert_equal(File.join(Dir.pwd,'etc/xdg', file), XDG.xdg_config_file(file))
  end

  def test_xdg_cache_file
    file = 'foo.cache'
    assert_equal(File.join(Dir.pwd,'home/.cache', file), XDG.xdg_cache_file(file))
  end

  # Test the working directory variations.

  def test_xdg_config_work
    assert_equal(File.join(Dir.pwd,'.config'), XDG.xdg_config_work)
  end

  def test_xdg_data_work
    assert_equal(File.join(Dir.pwd,'.share'), XDG.xdg_data_work)
  end

  def test_xdg_cache_work
    assert_equal(File.join(Dir.pwd,'.cache'), XDG.xdg_cache_work)
  end

end

