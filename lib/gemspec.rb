#!/usr/bin/env ruby
require File.expand_path('../catalog/version.rb', __FILE__)
version = Refinery::Catalog.version
raise "Could not get version so gemspec can not be built" if version.nil?
files = %w( readme.md license.md  )
%w(app config generators lib public rails test vendor).each do |dir|
  files += Dir.glob("#{dir}/**/*") if File.directory?(dir)
end

gemspec = <<EOF
Gem::Specification.new do |s|
  s.name              = %q{refinerycms-catalog}
  s.version           = %q{#{version}}
  s.description       = %q{A really straightforward open source Ruby on Rails catalog plugin designed for integration with RefineryCMS}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{Ruby on Rails catalog plugin for RefineryCMS.}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com}
  s.authors           = ['Resolve Digital']
  s.require_paths     = %w(lib)

  s.add_dependency    'refinerycms', '>= 0.9.9'

  s.files             = [
    '#{files.join("',\n    '")}'
  ]
  #{"s.test_files        = [
    '#{Dir.glob("test/**/*.rb").join("',\n    '")}'
  ]" if File.directory?("test")}
end
EOF

File.open(File.expand_path("../../refinerycms-catalog.gemspec", __FILE__), 'w').puts(gemspec)

