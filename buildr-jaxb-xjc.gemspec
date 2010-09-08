require File.expand_path(File.dirname(__FILE__) + '/lib/buildr/jaxb_xjc/version')

Gem::Specification.new do |spec|
  spec.name           = 'buildr-jaxb-xjc'
  spec.version        = Buildr::JaxbXjc::Version::STRING
  spec.authors        = ['Mark Petrovic', 'Peter Donald']
  spec.email          = ["mspetrovic@gmail.com","peter@realityforge.org"]
  spec.homepage       = "http://github.com/realityforge/buildr-jaxb-xjc"
  spec.summary        = "Buildr extension to execute the XJC binding compiler"
  spec.description    = <<-TEXT
This is a buildr extension that tasks to execute the XJC binding compiler. 
  TEXT

  spec.files          = Dir['{lib,spec}/**/*', '*.gemspec'] +
                        ['LICENSE', 'NOTICE', 'README.rdoc', 'CHANGELOG', 'Rakefile']
  spec.require_paths  = ['lib']

  spec.has_rdoc         = true
  spec.extra_rdoc_files = 'README.rdoc', 'LICENSE', 'NOTICE', 'CHANGELOG'
  spec.rdoc_options     = '--title', "#{spec.name} #{spec.version}", '--main', 'README.rdoc'

  spec.post_install_message = "Thanks for installing the JAXB XJC extension for Buildr"
end
