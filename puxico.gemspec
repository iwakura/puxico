require File.join([File.dirname(__FILE__),'lib','puxico','version.rb'])

spec = Gem::Specification.new do |s|
  s.name = 'puxico'
  s.version = Puxico::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = 'Iwakura Taro'
  s.email = 'taro@mail333.com'
  s.summary = 'CLI tool for working with Puxing radio config files.'
  s.license = 'BSD-3-Clause'
  s.files = `git ls-files`.split("\n")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','puxico.rdoc', 'LICENSE.txt']
  s.rdoc_options << '--title' << 'puxico' << '--main' << 'README.rdoc'
  s.bindir = 'bin'
  s.executables << 'puxico'
  s.add_development_dependency('rake', '~>12.0')
  s.add_development_dependency('rdoc', '~>5.1')
  s.add_development_dependency('test-unit', '~>3.2')
  s.add_runtime_dependency('gli','~>2.16')
end
