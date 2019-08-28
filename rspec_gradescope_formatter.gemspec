Gem::Specification.new do |s|
  s.name = 'rspec_gradescope_formatter'
  s.version = '0.0.1'
  s.require_paths = ['lib']
  s.authors = ['Armando Fox']
  s.date = '2019-08-29'
  s.summary     = 'RSpec output formatter that follows Gradescope autograder spec'
  s.description = 'RSpec output formatter that follows Gradescope autograder spec'
  s.email = 'fox@berkeley.edu'
  s.files = %w(Gemfile Gemfile.lock README.md VERSION lib/rspec_gradescope_formatter.rb)
  s.homepage = 'https://github.com/saasbook/rspec_gradescope_formatter'
  s.license = 'CC-NC-BY-SA'
  s.add_runtime_dependency 'rspec-core', '~> 3.0.0'
  s.add_runtime_dependency 'json'
end
