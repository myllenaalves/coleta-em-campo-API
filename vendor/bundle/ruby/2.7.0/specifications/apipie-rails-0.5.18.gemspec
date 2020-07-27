# -*- encoding: utf-8 -*-
# stub: apipie-rails 0.5.18 ruby lib

Gem::Specification.new do |s|
  s.name = "apipie-rails".freeze
  s.version = "0.5.18"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pavel Pokorny".freeze, "Ivan Necas".freeze]
  s.date = "2020-05-21"
  s.description = "Rails REST API documentation tool".freeze
  s.email = ["pajkycz@gmail.com".freeze, "inecas@redhat.com".freeze]
  s.homepage = "http://github.com/Apipie/apipie-rails".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Rails REST API documentation tool".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 4.1"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<maruku>.freeze, [">= 0"])
    s.add_development_dependency(%q<RedCloth>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_development_dependency(%q<json-schema>.freeze, ["~> 2.8"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 4.1"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<maruku>.freeze, [">= 0"])
    s.add_dependency(%q<RedCloth>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_dependency(%q<json-schema>.freeze, ["~> 2.8"])
  end
end
