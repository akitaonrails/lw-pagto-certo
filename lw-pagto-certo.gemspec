# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{lw-pagto-certo}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fabio Akita"]
  s.date = %q{2009-03-27}
  s.description = %q{Integração para o serviço Pagamento Certo, da Locaweb.}
  s.email = %q{fabio.akita@locaweb.com.br}
  s.files = ["History.txt", "lib", "lib/lw-pagto-certo", "lib/lw-pagto-certo/default.rb", "lib/lw-pagto-certo/defaultDriver.rb", "lib/lw-pagto-certo/defaultMappingRegistry.rb", "lib/lw-pagto-certo/pagto-20090326.wsdl", "lib/lw-pagto-certo/version.rb", "lib/lw-pagto-certo.rb", "Manifest.txt", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://pagamentocerto.com.br}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Integração para o serviço Pagamento Certo, da Locaweb.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["> 2.0.2"])
      s.add_runtime_dependency(%q<builder>, ["> 2.1.0"])
      s.add_runtime_dependency(%q<soap4r>, ["> 1.5.0"])
    else
      s.add_dependency(%q<activesupport>, ["> 2.0.2"])
      s.add_dependency(%q<builder>, ["> 2.1.0"])
      s.add_dependency(%q<soap4r>, ["> 1.5.0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["> 2.0.2"])
    s.add_dependency(%q<builder>, ["> 2.1.0"])
    s.add_dependency(%q<soap4r>, ["> 1.5.0"])
  end
end
