# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'password_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'password_manager'
  spec.version       = PasswordManager::VERSION
  spec.authors       = ['Jake']
  spec.email         = ['jacob.michael.mayer@gmail.com']

  spec.summary       = 'Manages passwords locally'
  spec.homepage      = Dir.chdir(File.expand_path(__dir__)) do
    `git remote get-url origin`.chomp
  end
  spec.license = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = '' # do not push anywhere

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_runtime_dependency 'faker'
  spec.add_runtime_dependency 'thor'
end
