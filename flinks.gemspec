# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: flinks 0.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "flinks".freeze
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Philippe Dionne".freeze]
  s.date = "2019-12-13"
  s.description = "Flinks financial services API client".freeze
  s.email = "dionne.phil@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".ruby-version",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "flinks.gemspec",
    "lib/flinks.rb",
    "lib/flinks/api/account.rb",
    "lib/flinks/api/authorize.rb",
    "lib/flinks/api/card.rb",
    "lib/flinks/api/refresh.rb",
    "lib/flinks/api/statement.rb",
    "lib/flinks/client.rb",
    "lib/flinks/error.rb",
    "lib/flinks/request.rb",
    "spec/lib/api/account_spec.rb",
    "spec/lib/api/authorize_spec.rb",
    "spec/lib/api/card_spec.rb",
    "spec/lib/api/refresh_spec.rb",
    "spec/lib/api/statement_spec.rb",
    "spec/lib/client_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/phildionne/flinks".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Flinks API client".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<http>.freeze, ["~> 4.2"])
      s.add_runtime_dependency(%q<dry-schema>.freeze, ["~> 1.4"])
      s.add_runtime_dependency(%q<dry-initializer>.freeze, ["~> 3"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3", "~> 5"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.11"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 6"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    else
      s.add_dependency(%q<http>.freeze, ["~> 4.2"])
      s.add_dependency(%q<dry-schema>.freeze, ["~> 1.4"])
      s.add_dependency(%q<dry-initializer>.freeze, ["~> 3"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3", "~> 5"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.11"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 6"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_dependency(%q<shoulda-matchers>.freeze, ["~> 4.0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<http>.freeze, ["~> 4.2"])
    s.add_dependency(%q<dry-schema>.freeze, ["~> 1.4"])
    s.add_dependency(%q<dry-initializer>.freeze, ["~> 3"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3", "~> 5"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.11"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<shoulda-matchers>.freeze, ["~> 4.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end

