control 'alfresco-04' do
  impact 0.7
  title 'Libreoffice installation'
  desc 'Checks to be sure that Libreoffice has been installed correctly'

  describe file('opt/libreoffice5.2/') do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe command('/opt/libreoffice5.2/program/soffice.bin --version') do
    its(:stdout) { should include('LibreOffice 5.2.1.2') }
  end
  describe file('/tmp/kitchen/cache/LibreOffice_5.2.1.2_Linux_x86-64_rpm.tar.gz') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'tomcat' }
  end
  describe command('tar -xf /tmp/kitchen/cache/LibreOffice_5.2.1.2_Linux_x86-64_rpm.tar.gz') do
    its('exit_status') { should eq 0 }
  end

  describe directory('/tmp/kitchen/cache/LibreOffice_5.2.1.2_Linux_x86-64_rpm') do
    it { should exist }
    it { should be_directory }
  end

  describe command('yum -y localinstall /tmp/kitchen/cache/LibreOffice_5.2.1.2_Linux_x86-64_rpm/RPMS/*.rpm') do
    its('exit_status') { should eq 0 }
  end

  describe command('chown tomcat:tomcat -R /opt/libreoffice5.2') do
    its('exit_status') { should eq 0 }
  end

  # describe command("yum install -y *fonts.noarch --exclude='tv-fonts chkfontpath pagul-fonts\*'") do
  #     its('exit_status') { should eq 0 }
  # end
  # packages.each do |package|
  #   describe package(package ) do
  #     it { should be_installed }
  #   end
  # end
  describe package('perl-Image-ExifTool') do
    it { should be_installed }
  end
end
