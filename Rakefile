require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/snip_snap/version'

spec = Gem::Specification.new do |s|
  s.name             = 'snip-snap'
  s.version          = SnipSnap::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "A ruby library that allows you to extract images from popular image-sharing services"
  s.author           = 'Patrick Reagan'
  s.email            = 'reaganpr@gmail.com'
  s.homepage         = 'http://sneaq.net'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib,test}/**/*") - ['test/flickr_api_key']
  # s.executables    = ['snip-snap']
  
  s.add_dependency('curb', '>= 0.5.1.0')
  s.add_dependency('fleakr', '>= 0.5.1')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/unit/**/*_test.rb"]
  t.verbose = true
end

Rake::TestTask.new(:integration) do |t|
  t.libs << 'test'
  t.test_files = FileList["test/integration/*_test.rb"]
  t.verbose = true
end

begin
  require 'rcov/rcovtask'

  Rcov::RcovTask.new(:coverage) do |t|
    t.libs       = ['test']
    t.test_files = FileList["test/unit/**/*_test.rb"]
    t.verbose    = true
    t.rcov_opts  = ['--text-report', "-x #{Gem.path}", '-x /Library/Ruby', '-x /usr/lib/ruby']
  end
  
  task :default => :coverage
  
rescue LoadError
  warn "\n**** Install rcov (sudo gem install relevance-rcov) to get coverage stats ****\n"
  task :default => :test
end


desc 'Generate the gemspec to serve this Gem from Github'
task :github do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end