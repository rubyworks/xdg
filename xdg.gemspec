Gem::Specification.new do |s|
  s.name        = 'xdg'
  s.version     = '2.2.6'
  s.summary     = 'XDG provides an interface for using XDG directory standard.'
  s.description = 'XDG provides a module for supporting the XDG Base Directory Standard.'

  s.authors     = ['Trans']
  s.email       = ['transfire@gmail.com']

  s.homepage    = 'https://github.com/rubyworks/xdg'
  s.license     = 'BSD-2-Clause'

  s.required_ruby_version = '>= 3.1'

  s.files       = Dir['lib/**/*', 'LICENSE.txt', 'README.md', 'HISTORY.md', 'demo/**/*']
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '>= 13'
  s.add_development_dependency 'qed', '>= 2.9'
  s.add_development_dependency 'ae', '>= 1.8'
end
