module XDG

  #
  # Access metadata via constants.
  #
  def self.const_missing(const_name)
    name = const_name.to_s.downcase
    index.key?(name) ? index[name] : super(const_name)
  end

  #
  # Access to index data.
  #
  def self.index
    @index ||= (
      require 'yaml'
      file = File.join(File.dirname(__FILE__) + '/../xdg.yml')
      YAML.load_file(file)
    )
  end

end
