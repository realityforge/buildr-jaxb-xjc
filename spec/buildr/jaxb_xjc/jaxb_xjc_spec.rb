require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

XSD_FILE = File.expand_path(File.dirname(__FILE__) + '/../../fixtures/wildfire-1.3.xsd')

describe "Buildr::JaxbXjc" do
  describe "compiled with specified xsd" do
    before do
      @foo = define "foo" do
        project.version = "2.1.3"
        compile.from compile_jaxb(XSD_FILE, "-quiet", :package => "org.foo.api")
        package :jar
      end
      task('compile').invoke
    end

    it "produce .java files in the correct location" do
      File.should be_exist(@foo._("target/generated/jaxb/org/foo/api/Agency.java"))
      File.should be_exist(@foo._("target/generated/jaxb/org/foo/api/LatLongCoordinate.java"))
      File.should be_exist(@foo._("target/generated/jaxb/org/foo/api/ObjectFactory.java"))
      File.should be_exist(@foo._("target/generated/jaxb/org/foo/api/Wildfire.java"))
    end

    it "produce .class files in the correct location" do
      File.should be_exist(@foo._("target/classes/org/foo/api/Agency.class"))
      File.should be_exist(@foo._("target/classes/org/foo/api/LatLongCoordinate.class"))
      File.should be_exist(@foo._("target/classes/org/foo/api/ObjectFactory.class"))
      File.should be_exist(@foo._("target/classes/org/foo/api/Wildfire.class"))
    end
  end
end
