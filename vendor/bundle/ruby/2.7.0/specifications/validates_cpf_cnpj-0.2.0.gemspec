# -*- encoding: utf-8 -*-
# stub: validates_cpf_cnpj 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "validates_cpf_cnpj".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Reginaldo Francisco".freeze]
  s.date = "2013-01-29"
  s.description = "CPF and CNPJ validations for ActiveModel and Rails".freeze
  s.email = ["naldo_ds@yahoo.com.br".freeze]
  s.homepage = "http://github.com/rfs/validates_cpf_cnpj".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "CPF/CNPJ ActiveModel validations".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.0.0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 3.0.0"])
  end
end
