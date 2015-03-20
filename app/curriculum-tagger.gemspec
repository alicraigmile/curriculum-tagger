#require 'lib/curriculum-tagger/version'
  #s.version = CurriculumTagger::VERSION

Gem::Specification.new do |s|
  s.name = "curriculum-tagger"
  s.version = '0.0.0'
  s.platform = Gem::Platform::RUBY
  s.license = 'MIT'
  s.homepage = "https://github.com/alicraigmile/curriculum-tagger"
  s.summary = "Tag learning web content against a curriculum from your browser."
  s.description = "An Chrome Extension, Firefox Addon and some content services for tagging learning web content against a curriculum."
  s.authors = ['Ali Craigmile']
  s.email = ['ali@craigmile.com']
  s.extra_rdoc_files = ["README.md"]
  s.files = `git ls-files`.split("\n")
  s.executables = ["curriculum-tagger"]

  s.add_dependency 'sinatra'
  s.add_dependency 'activerecord'
  s.add_dependency 'sqlite3'
  s.add_dependency 'builder'
  s.add_dependency 'json'
  s.add_dependency 'rack-conneg', '>=0.1.5'
  s.add_dependency 'git-version-bump'
  s.add_dependency 'i18n', '>=0.7.0'
end
