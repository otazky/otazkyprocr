# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-own_questions'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Own Questions extension for Refinery CMS'
  s.date              = '2012-12-20'
  s.summary           = 'Own Questions extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.5'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.5'
end
