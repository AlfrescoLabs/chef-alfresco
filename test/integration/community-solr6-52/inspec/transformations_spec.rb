control 'alfresco-10' do
  impact 0.7
  title 'Libreoffice installation'
  desc 'Checks to be sure that Libreoffice has been installed correctly'

  describe directory('/opt/libreoffice5.2/') do
    it { should exist }
    it { should be_directory }
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

  describe command('yum list installed | grep libreoffice') do
    its(:stdout) { should include('libreoffice5.2.x86_64') }
    its(:stdout) { should include('libreoffice5.2-base.x86_64') }
    its(:stdout) { should include('libreoffice5.2-calc.x86_64') }
    its(:stdout) { should include('libreoffice5.2-dict-en.x86_64') }
    its(:stdout) { should include('libreoffice5.2-dict-es.x86_64') }
    its(:stdout) { should include('libreoffice5.2-dict-fr.x86_64') }
    its(:stdout) { should include('libreoffice5.2-draw.x86_64') }
    its(:stdout) { should include('libreoffice5.2-en-US.x86_64') }
    its(:stdout) { should include('libreoffice5.2-freedesktop-menus.noarch') }
    its(:stdout) { should include('libreoffice5.2-impress.x86_64') }
    its(:stdout) { should include('libreoffice5.2-math.x86_64') }
    its(:stdout) { should include('libreoffice5.2-ure.x86_64') }
    its(:stdout) { should include('libreoffice5.2-writer.x86_64') }
  end

  describe command('chown tomcat:tomcat -R /opt/libreoffice5.2') do
    its('exit_status') { should eq 0 }
  end

  describe package('perl-Image-ExifTool') do
    it { should be_installed }
  end
end
