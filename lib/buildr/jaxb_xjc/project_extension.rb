require 'buildr'
require 'buildr/java'
require 'buildr/java/ant'

# Wrapped JAXB-XJC compiler
# https://jaxb.dev.java.net/nonav/2.2.1/docs/xjcTask.html

module Buildr
  module JaxbXjc

    VERSION = "2.2.1"

    REQUIRES = ["javax.xml.bind:jaxb-api:jar:#{VERSION}",
                "com.sun.xml.bind:jaxb-impl:jar:#{VERSION}",
                "com.sun.xml.bind:jaxb-xjc:jar:#{VERSION}"]

    class << self
      def doWork(options)
        outdir = options[:outdir]
        schemafile = options[:schemafile]
        package = options[:package]

        pkgdir = outdir + '/' + package.gsub('.', '/')
        mkdir_p pkgdir.to_s

        file(outdir) do |dir|
          mkdir_p dir.to_s
          Buildr.ant('xjc') do |ant|
            ant.taskdef :name=>"xjc", :classname=>"com.sun.tools.xjc.XJCTask", :classpath=>requires.join(File::PATH_SEPARATOR)
            ant.xjc :schema=>schemafile, :destdir=>dir, :package=>package, :removeOldOutput=>'yes' do
              ant.produces :dir => pkgdir, :includes => '**/*.java'
            end
          end
        end
      end

      def requires
        @requires ||= Buildr.artifacts(REQUIRES).each { |artifact| artifact.invoke }.map(&:to_s)
      end
    end

    def compile_jaxb(options = {})
      JAXB_XJC.doWork jaxb_opts.merge(options)
    end

  end

  class Project
    include JaxbXjc
  end
end