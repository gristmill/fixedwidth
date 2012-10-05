# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fixedwidth/version'

Gem::Specification.new do |gem|
  gem.name          = "fixedwidth"
  gem.version       = Fixedwidth::VERSION
  gem.authors       = ["Sean Behan"]
  gem.email         = ["inbox@seanbehan.com"]
  gem.description   = %q{Fixedwidth data parsing.}
  gem.summary       = %q{This is a bare bones gem that lets you parse fixed width data files and transform them into CSV or Ruby hashes.}
  gem.homepage      = "https://github.com/gristmill/fixedwidth"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
