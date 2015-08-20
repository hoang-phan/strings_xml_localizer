# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strings_xml_localizer/version'

Gem::Specification.new do |spec|
  spec.name          = "strings_xml_localizer"
  spec.version       = StringsXmlLocalizer::VERSION
  spec.authors       = ["Hoang Phan"]
  spec.email         = ["hoang.phan@eastagile.com"]
  spec.summary       = "Localize strings.xml"
  spec.description   = "A simple gem to localize strings.xml files in android"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"

  spec.add_dependency "ox"
  spec.add_dependency "go_translator"
end
