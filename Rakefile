require 'rubygems'
require 'rubygems/package_task'
require 'rake/clean'
require 'rake/testtask'
require 'rdoc/task'

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.rdoc_files.include('README.rdoc', 'LICENSE.txt', 'lib/**/*.rb', 'bin/**/*')
  rd.title = 'puxico'
end

spec = eval(File.read('puxico.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test
