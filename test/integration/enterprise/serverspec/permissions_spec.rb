require 'spec_helper'

services = ["alfresco", "solr", "share"]

describe "Alfresco folder permission" do
  describe file("/usr/share/tomcat-alfresco/webapps") do
    it { should be_owned_by 'root' }

    it 'should be writable by root' do
    	should be_writable.by_user('root')
    end

    it 'should be readable by root' do
    	should be_readable.by_user('root')
    end

    it 'should be writable by tomcat' do
    	should be_writable.by_user('tomcat')
    end

    it 'should be readable by tomcat' do
    	should be_readable.by_user('tomcat')
    end
  end

  ['lib','classes'].each do |alfresco_configuration_folder|
    describe file("/usr/share/tomcat-alfresco/webapps/alfresco/WEB-INF/#{alfresco_configuration_folder}") do
      it { should be_owned_by 'root' }

      it 'should be writable by root' do
        should be_writable.by_user('root')
      end

      it 'should be readable by root' do
        should be_readable.by_user('root')
      end

      it 'should not be writable by tomcat' do
        should_not be_writable.by_user('tomcat')
      end

      it 'should be executable by tomcat' do
        should be_executable.by_user('tomcat')
      end

      it 'should be readable by tomcat' do
        should be_readable.by_user('tomcat')
      end
    end
  end


  describe file ("/etc/tomcat/jmxremote.password") do
    it { should be_owned_by 'tomcat' }

    it "should be writable by the tomcat user" do
    	should be_writable.by_user('tomcat')
    end

    it 'should be readable by the tomcat user' do
    	should be_readable.by_user('tomcat')
    end

    it "should not be readable by anyone else (nginx as example)" do
      should_not be_readable.by_user('nginx')
    end

    it "should not be writable by anyone else (nginx as example)" do
      should_not be_writable.by_user('nginx')
    end

    it "should not be executable by anyone else (nginx as example)" do
      should_not be_executable.by_user('nginx')
    end
  end
  services.each do |service|
    describe file("/var/log/tomcat-#{service}") do
      it { should be_owned_by 'tomcat' }

      it "should be writable by the tomcat user" do
      	should be_writable.by_user('tomcat')
      end

      it 'should be readable by the tomcat user' do
      	should be_readable.by_user('tomcat')
      end

      it "should not be readable by anyone else (nginx as example)" do
        should_not be_readable.by_user('nginx')
      end

      it "should not be writable by anyone else (nginx as example)" do
        should_not be_writable.by_user('nginx')
      end

      it "should not be executable by anyone else (nginx as example)" do
        should_not be_executable.by_user('nginx')
      end
    end

    describe file("/var/cache/tomcat-#{service}") do
      it { should be_owned_by 'tomcat' }

      it "should be writable by the tomcat user" do
        should be_writable.by_user('tomcat')
      end

      it 'should be readable by the tomcat user' do
        should be_readable.by_user('tomcat')
      end

      it "should not be readable by anyone else (nginx as example)" do
        should_not be_readable.by_user('nginx')
      end

      it "should not be writable by anyone else (nginx as example)" do
        should_not be_writable.by_user('nginx')
      end

      it "should not be executable by anyone else (nginx as example)" do
        should_not be_executable.by_user('nginx')
      end
    end
  end
end
