$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mina_ryver/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mina_ryver"
  s.version     = MinaRyver::VERSION
  s.authors     = ["Conficker1805"]
  s.email       = ["conficker1805@gmail.com"]
  s.homepage    = "https://github.com/conficker1805/mina_ryver"
  s.summary     = "Mina bindings for Ryver"
  s.description = "Adds tasks to aid in the Ryver notifications."

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "mina"
end
