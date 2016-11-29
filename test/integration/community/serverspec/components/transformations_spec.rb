require 'spec_helper'

describe "LibreOffice installation" do
  describe file("/opt/libreoffice4.4/") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe command("cat /usr/share/tomcat/shared/classes/alfresco-global.properties") do
    its(:stdout) { should contain("jodconverter.officeHome=/opt/libreoffice4.4/") }
  end
end
