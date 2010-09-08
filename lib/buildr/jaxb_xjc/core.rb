module Buildr
  module JaxbXjc
    class << self

      def jaxb_version
        "2.2.1"
      end

      # The specs for requirements
      def requires
        [
          "javax.xml.bind:jaxb-api:jar:#{jaxb_version}",
          "com.sun.xml.bind:jaxb-impl:jar:#{jaxb_version}",
          "com.sun.xml.bind:jaxb-xjc:jar:#{jaxb_version}"
        ]
      end

      # Repositories containing the requirements
      def remote_repository
        "http://download.java.net/maven/2"
      end

      def xjc(*args)
        cp = Buildr.artifacts(self.requires).each(&:invoke).map(&:to_s)
        Java::Commands.java 'com.sun.tools.xjc.XJCFacade', *(args + [{ :classpath => cp }])
      end
    end
  end
end
