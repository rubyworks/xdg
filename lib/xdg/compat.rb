module XDG

  def data_home
    data.home
  end

  def config_home
    config.home
  end

  def cache_home
    cache.home
  end


  def data_dirs
    data.home
  end

  def config_dirs
    config.dirs
  end

  #def cache_dirs
  #  cache.dirs
  #end


  def data_select(*args, &block)
    data.search(*args, &block)
  end

  def config_select(*args, &block)
    config.search(*args, &block)
  end

  def cache_select(*args, &block)
    cache.search(*args, &block)
  end


  def data_find(*args, &block)
    data.find(*args, &block)
  end

  def config_find(*args, &block)
    config.select(*args, &block)
  end

  def cache_find(*args, &block)
    cache.find(*args, &block)
  end


  def config_work
    config.work
  end

  def cache_work
    cache.work
  end

end

# Copyright (c) 2008,2009 Thomas Sawyer
# Distributed under the terms of the LGPL v3.
